//
//  CityViewModel.swift
//  Majira
//
//  Created by MAC on 21/07/2025.
//

import Foundation


@MainActor
class CityViewModel:ObservableObject {
    @Published var cities:[City] = []
    @Published var cityWeatherList: [CityWeather] = []
    private var fetchedCityNamesCache: Set<String> = []
    @Published var city:City? = nil
    @Published var isLoadingWeather: Bool = false
    private let repo:CityRepository = CityRepositoryImpl.shared
    
    func loadCities() {
        do {
            cities = try repo.getAllCities()
        } catch {
            print("Failed to load: \(error)")
        }
    }
    
    
    func loadCity(id: UUID) {
        print("Trying to load city with ID: \(id)")
        do {
            let loadedCity = try repo.getCityById(id: id)
            print("Found city: \(loadedCity?.city ?? "nil")")
            self.city = loadedCity
        } catch {
            print("Failed to load task: \(error)")
        }
    }
    
    
    
    func addCity(city:City) {
        do {
            if !cities.contains(where: { $0.id == city.id }) {
                cities.append(city)
                try repo.addCity(city: city)
                loadCities()
                fetchWeatherForCity(city)
            }
            
        } catch {
            print("Create failed: \(error)")
        }
    }
    
    func deleteCityById(cityName:String) {
        do {
            try repo.deleteCityByName(cityName:cityName)
            loadCities()
        } catch {
            print("Delete failed: \(error)")
        }
    }
    
    func deleteAllCities() {
        do {
            try repo.deleteAllCities()
            loadCities()
        } catch {
            print("Delete failed: \(error)")
        }
    }
    
    func updateCity(_ city: City) {
        do {
            try repo.updateCity(city: city)
            loadCities()
        } catch {
            print("Update failed: \(error)")
        }
    }
    
    func fetchWeatherForCity(_ city: City) {
        if fetchedCityNamesCache.contains(city.city) {
            print("Weather for \(city.city) already fetched in this session, skipping.")
            return
        }
        
        let homeViewModel = HomeViewModel()
        
        Task {
            await homeViewModel.fetchWeaatherData(
                lat: "\(city.latitude)",
                lon: "\(city.longitude)",
                onSuccess: { [weak self] response in
                    guard let self = self else { return }
                    let current = response.current
                    let cityWeather = CityWeather(
                        cityName: city.city,
                        temperature: Utils.shared.kelvinToCelsiusString(current.temp),
                        iconName: Utils.shared.mapIconToSFImage(icon: current.weather.first?.icon ?? ""),
                        condition: current.weather.first?.description.capitalized ?? "Unknown",
                        sunDuration: Utils.shared.calculateDaylightDuration(sunrise: current.sunrise, sunset: current.sunset),
                        humidity: "\(Int(current.humidity))",
                        windSpeed: "\(current.windSpeed)",
                        weatherColor: Utils.shared.weatherColor(for: current.weather.first?.main ?? "")
                    )
                    Task { @MainActor in
                        if !self.cityWeatherList.contains(where: { $0.cityName == cityWeather.cityName }) {
                            self.cityWeatherList.append(cityWeather)
                            self.fetchedCityNamesCache.insert(city.city) // Mark as fetched
                            self.cityWeatherList.sort { $0.cityName < $1.cityName }
                        } else {
                            if let index = self.cityWeatherList.firstIndex(where: { $0.cityName == cityWeather.cityName }) {
                                self.cityWeatherList[index] = cityWeather
                            }
                        }
                    }
                },
                onFailure: { error in
                    print("Failed to fetch weather for \(city.city): \(error)")
                }
            )
        }
    }
    
    func refreshAllCityWeather() {
        guard !isLoadingWeather else { return }

        isLoadingWeather = true
        self.cityWeatherList = []
        self.fetchedCityNamesCache = []

        let homeViewModel = HomeViewModel()

        let dispatchGroup = DispatchGroup()

        if cities.isEmpty {
            isLoadingWeather = false
            return
        }

        for city in cities {
            dispatchGroup.enter()
            Task {
                await homeViewModel.fetchWeaatherData(
                    lat: "\(city.latitude)",
                    lon: "\(city.longitude)",
                    onSuccess: { [weak self] response in
                        guard let self = self else { dispatchGroup.leave(); return }
                        let current = response.current
                        let cityWeather = CityWeather(
                            cityName: city.city,
                            temperature: Utils.shared.kelvinToCelsiusString(current.temp),
                            iconName: Utils.shared.mapIconToSFImage(icon: current.weather.first?.icon ?? ""),
                            condition: current.weather.first?.description.capitalized ?? "Unknown",
                            sunDuration: Utils.shared.calculateDaylightDuration(sunrise: current.sunrise, sunset: current.sunset),
                            humidity: "\(Int(current.humidity))",
                            windSpeed: "\(current.windSpeed)",
                            weatherColor: Utils.shared.weatherColor(for: current.weather.first?.main ?? "")
                        )
                        Task { @MainActor in
                            if !self.cityWeatherList.contains(where: { $0.cityName == cityWeather.cityName }) {
                                self.cityWeatherList.append(cityWeather)
                                self.fetchedCityNamesCache.insert(city.city)
                                self.cityWeatherList.sort { $0.cityName < $1.cityName }
                            } else {
                                if let index = self.cityWeatherList.firstIndex(where: { $0.cityName == cityWeather.cityName }) {
                                    self.cityWeatherList[index] = cityWeather
                                }
                            }
                        }
                        dispatchGroup.leave()
                    },
                    onFailure: { error in
                        print("Failed to fetch weather for \(city.city): \(error)")
                        dispatchGroup.leave()
                    }
                )
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.isLoadingWeather = false
            print("All weather fetches completed.")
        }
    }
}
