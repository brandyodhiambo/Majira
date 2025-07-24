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
                            text = ""
                        } else {
                            print("Failed to get coordinates.")
                        }
                    }
                }
            )
            
            Text("My Cities")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(.theme.onSurfaceColor.opacity(0.7))
            
            if cityViewModel.isLoadingWeather {
                Spacer()
                LoadingOverlay()
                Spacer()
            } else if cityViewModel.cityWeatherList.isEmpty && !cityViewModel.cities.isEmpty {
                Spacer()
                Text("No weather data available. Please check your internet connection or try again.")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(.theme.onSurfaceColor.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            } else if cityViewModel.cityWeatherList.isEmpty && cityViewModel.cities.isEmpty {
                Spacer()
                Text("No cities added yet. Search for a city above to add it!")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(.theme.onSurfaceColor.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            } else {
                ScrollView(.vertical,showsIndicators: false){
                    VStack(spacing: 12) {
                        ForEach(cityViewModel.cityWeatherList, id: \.cityName) { cityWeather in
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
            cityViewModel.refreshAllCityWeather()
        }
    }
}


#Preview {
    NavigationView{
        CityView()
    }
}
