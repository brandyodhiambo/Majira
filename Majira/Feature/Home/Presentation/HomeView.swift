//
//  HomeView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var themesViewModel: ThemesViewModel
    var themeToggleIcon: String {
        themesViewModel.currentTheme == .dark ? "sun.max.fill" : "moon.fill"
    }
    @StateObject var locationManager = LocationManager()
    @StateObject var homeViewModel: HomeViewModel = .init()
    @State var weatherResponse: WeatherResponse?
    @State var hourlyForecasts: [HourlyForecast] = []
    @State private var locationName: String = "Loading..."

    

    var body: some View {
        ZStack{
            if homeViewModel.dataState == .isLoading {
                LottieView(animationName: "flying-weather")
                    .frame(width: 70, height: 70)
            }
        }
        ScrollView(.vertical,showsIndicators: false){
            VStack(alignment:.leading,spacing:16){
                // Upper Part
                VStack(alignment:.center, spacing:16){
                   LocationHeaderView(location: locationName)
                    
                    WeatherIconView(iconCode: weatherResponse?.current.weather[0].icon ?? "", size: 150)
                    
                    Text("\(Utils.shared.formattedToday())")
                       .font(.custom("Poppins-Medium", size: 16))
                       .foregroundColor(.theme.onSurfaceColor)
                    
                    Text("\(String(format: "%.2f", weatherResponse?.current.temp ?? 0.0))°C")
                       .font(.custom("Poppins-ExtraBold", size: 30))
                       .foregroundColor(Color.theme.onSurfaceColor.opacity(0.9))
                   
                   // weather condition
                   HStack (spacing:12){
                       Spacer()
                       WeatherConditionView(
                           icon: "wind", condition: "\(String(format: "%.2f", weatherResponse?.current.windSpeed ?? 0.0)) km/h"
                       )
                       Spacer()
                       WeatherConditionView(
                           icon: "drop.fill", condition: "\(weatherResponse?.current.humidity ?? 0)%"
                       )
                       Spacer()
                       WeatherConditionView(
                        icon: "sun.max.fill", condition: Utils.shared.calculateDaylightDuration(sunrise: weatherResponse?.current.sunrise ?? 0.0, sunset: weatherResponse?.current.sunset ?? 0.0)
                       )
                       Spacer()
                   }
                }
                
                VStack(alignment:.leading, spacing:16){
                    Text("Hourly Forecast")
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(.theme.onSurfaceColor.opacity(0.7))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(hourlyForecasts, id: \.dt) { forecast in
                                let forecastDate = Date(timeIntervalSince1970: forecast.dt)
                                let currentHour = Calendar.current.component(.hour, from: Date())
                                let forecastHour = Calendar.current.component(.hour, from: forecastDate)
                                let isNow = currentHour == forecastHour
                                
                                TemperatureCard(
                                    temperature: "\(Int(forecast.temp))°",
                                    iconName: Utils.shared.mapIconToSFImage(icon: forecast.weather.first?.icon ?? "01d"),
                                    date: forecastDate,
                                    isSelected: isNow
                                )
                            }
                        }
                        .padding()
                    }

                }
                .task{
                    await homeViewModel.fetchWeaatherData(
                        lat: locationManager.latitude.description,
                        lon: "\(locationManager.longitude)",
                        onSuccess:{ data in
                            self.weatherResponse = data
                            self.hourlyForecasts = data.hourly
                        },
                        onFailure: { error in
                           print("Debug: Failed to fetch weather data: \(error)")
                        }
                    )
                }
                .padding()
                
            }
        }
        .background(Color.theme.surfaceColor)
        .customTopAppBar(
            title: "",
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
        }
        .onAppear {
            Utils.shared.getCityAndCountry(latitude: locationManager.latitude, longitude: locationManager.longitude) { name in
                if let name = name {
                    locationName = name
                } else {
                    locationName = "Location not found"
                }
            }
        }

       
    }
    
    
}



#Preview {
    NavigationView {
        HomeView()
    }
}
