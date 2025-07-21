//
//  CityView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct CityView: View {
    @EnvironmentObject var tabRouter: TabRouter
    @EnvironmentObject var themesViewModel: ThemesViewModel
    var themeToggleIcon: String {
        themesViewModel.currentTheme == .dark ? "sun.max.fill" : "moon.fill"
    }

    @State var text: String = ""
    @StateObject var cityViewModel:CityViewModel = .init()
    @StateObject var homeViewModel: HomeViewModel = .init()
    @State var cityWeatherList: [CityWeather] = []


    
    @State var sampleCities: [CityWeather] = [
        CityWeather(cityName: "Nairobi", temperature: "23°C", iconName: "sun.max.fill",condition: "Sunny",weatherColor: .theme.sunnyYellow),
        CityWeather(cityName: "Mombasa", temperature: "29°C", iconName: "cloud.sun.fill",condition: "Sunny", weatherColor: .theme.cloudColor),
        CityWeather(cityName: "Kisumu", temperature: "26°C", iconName: "cloud.rain.fill",condition: "Sunny", weatherColor: .theme.rainColor),
        CityWeather(cityName: "Eldoret", temperature: "19°C", iconName: "cloud.fog.fill", condition: "Sunny",weatherColor: .theme.snowColor),
        CityWeather(cityName: "Nakuru", temperature: "21°C", iconName: "cloud.sun.fill",condition: "Sunny", weatherColor: .mint)
    ]
   

    
    var body: some View {
        let router = tabRouter.cityRouter
        VStack(alignment:.leading,spacing:16){
            InputFieldView(
                image:"",
                placeHolder: "Search City",
                text: $text,
                inputFieldStyle: .outlined,
                onSubmit: {
                    Utils.shared.getLatLon(from: text) { coordinate in
                        if let coordinate = coordinate {
                            print("Latitude: \(coordinate.latitude), Longitude: \(coordinate.longitude)")
                            let city = City(id: UUID(), city: text, latitude: coordinate.latitude, longitude: coordinate.longitude)
                            cityViewModel.addCity(city: city)
                        } else {
                            print("Failed to get coordinates.")
                        }
                    }
                }
            )
            
            Text("My Cities")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(.theme.onSurfaceColor.opacity(0.7))
            
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing: 12) {
                    ForEach(cityWeatherList, id: \.cityName) { cityWeather in
                        CityCardView(
                            cityName: cityWeather.cityName,
                            temperature: cityWeather.temperature,
                            iconName: cityWeather.iconName,
                            weatherColor: cityWeather.weatherColor,
                            onTap: {
                                print("tapped city: \(cityWeather.cityName)")
                                router.push(.cityDetails(city: cityWeather))
                            }
                        )
                    }
                }
            }
        }
        .padding()
        .background(Color.theme.surfaceColor)
        .customTopAppBar(
            title: "Choose City",
            leadingIcon: "",
            navbarTitleDisplayMode: .inline,
            onLeadingTap: {},
            trailingIcon: themeToggleIcon,
            onTrailingTap: {
                let nextTheme: ThemeModel = themesViewModel.currentTheme == .dark ? .light : .dark
                themesViewModel.changeTheme(to: nextTheme)
            }
        )
        .onAppear {
            themesViewModel.setAppTheme()
            cityViewModel.loadCities()
            fetchAllStoredCitiesWeather()

        }
    }
    
    private func fetchAllStoredCitiesWeather() {
          cityWeatherList = []
          for city in cityViewModel.cities {
              fetchCityWeather(city: city)
          }
      }

    private func fetchCityWeather(city: City) {
        Task {
            await homeViewModel.fetchWeaatherData(
                lat: "\(city.latitude)",
                lon: "\(city.longitude)",
                onSuccess: { response in
                    let current = response.current
                    let cityWeather = CityWeather(
                        cityName: city.city,
                        temperature: "\(Int(current.temp))°C",
                        iconName: Utils.shared.mapIconToSFImage(icon: current.weather.first?.icon ?? ""),
                        condition: current.weather.first?.description.capitalized ?? "Unknown",
                        weatherColor: Utils.shared.weatherColor(for: current.weather.first?.main ?? "")
                    )
                    Task { @MainActor in
                        cityWeatherList.append(cityWeather)
                    }
                },
                onFailure: { error in
                    print("Failed to fetch weather for \(city.city): \(error)")
                }
            )
        }
    }

}

#Preview {
    NavigationView{
        CityView()
    }
}
