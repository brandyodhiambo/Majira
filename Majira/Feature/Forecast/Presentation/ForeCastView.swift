//
//  ForeCastView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct ForeCastView: View {
    @EnvironmentObject var themesViewModel: ThemesViewModel
    @StateObject var homeViewModel: HomeViewModel = .init()
    @StateObject var locationManager = LocationManager()
    @State var weatherResponse: WeatherResponse?
    @State var hourlyForecasts: [HourlyForecast] = []
    var themeToggleIcon: String {
        themesViewModel.currentTheme == .dark ? "sun.max.fill" : "moon.fill"
    }
    var dailyForecasts: [DailyWeather] {
        weatherResponse?.daily ?? []
    }
    
    @State var sampleForecaset: [ForeCastItem] = [
        ForeCastItem(day: "Wednesday", date: "25 July", temperature: "23°", iconName: "sun.max.fill", weatherColor: .theme.sunnyYellow),
        ForeCastItem(day: "Thursday", date: "26 July", temperature: "24°", iconName: "cloud.sun.fill", weatherColor: .theme.cloudColor),
        ForeCastItem(day: "Friday", date: "27 July", temperature: "20°", iconName: "cloud.rain.fill", weatherColor: .theme.rainColor),
    ]
    
    var body: some View {

        VStack(spacing:16){
            VStack(alignment:.leading, spacing:16){
                Text("Today's Forecast")
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
            .padding([.top, .leading], 12)
            
            VStack(alignment:.leading, spacing:16){
                Text("Next Forecasts")
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundColor(.theme.onSurfaceColor.opacity(0.8))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(dailyForecasts, id: \.dt) { forecast in
                            ForecastRowView(
                                day: forecast.day,
                                date: forecast.dateString,
                                icon: forecast.iconName,
                                temperature: forecast.temperatureString,
                                weatherColor: forecast.weatherColor
                            )
                        }
                    }
                }
            }
            .padding([.top, .leading,.bottom], 12)
        }
        .background(Color.theme.surfaceColor)
        .overlay {
            Group {
                if homeViewModel.dataState == .isLoading {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.black.opacity(0.3))
                            .ignoresSafeArea()

                        LottieView(animationName: "flying-weather")
                            .frame(width: 70, height: 70)
                    }
                }
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
        .customTopAppBar(
            title: "Forecast Report",
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
    }
}

#Preview {
    NavigationView{
        ForeCastView()
    }
}
