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
    @State var dailyForecasts: [DailyWeather] = []
    var themeToggleIcon: String {
        themesViewModel.currentTheme == .dark ? "sun.max.fill" : "moon.fill"
    }
    
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
                                temperature: Utils.shared.kelvinToCelsiusString(forecast.temp),
                                iconName: Utils.shared.mapIconToSFImage(icon: forecast.weather.first?.icon ?? "01d"),
                                date: forecastDate,
                                isSelected: isNow,
                                weatherColor: Utils.shared.weatherColor(for: forecast.weather.first?.main ?? "")
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
                    .foregroundColor(.theme.onSurfaceColor.opacity(0.7))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(dailyForecasts, id: \.dt) { forecast in
                            var day: String {
                                let date = Date(timeIntervalSince1970: forecast.dt)
                                let formatter = DateFormatter()
                                formatter.dateFormat = "EEEE"
                                return formatter.string(from: date)
                            }

                            var dateString: String {
                                let date = Date(timeIntervalSince1970: forecast.dt)
                                let formatter = DateFormatter()
                                formatter.dateFormat = "d MMM"
                                return formatter.string(from: date)
                            }

                            var iconName: String {
                                Utils.shared.mapIconToSFImage(icon: forecast.weather.first?.icon ?? "01d")
                            }

                            var temperatureString: String {
                                "\(Utils.shared.kelvinToCelsiusString(forecast.temp.max)) / \(Utils.shared.kelvinToCelsiusString(forecast.temp.min))"
                            }

                            var weatherColor: Color {
                                Utils.shared.weatherColor(for: forecast.weather.first?.main ?? "")
                            }
                                        
                            ForecastRowView(
                                day: day,
                                date: dateString,
                                icon: iconName,
                                temperature: temperatureString,
                                weatherColor: weatherColor
                            )
                        }
                    }
                }
            }
            .padding([.top, .leading,.bottom], 12)
        }
        .background(Color.theme.surfaceColor)
        .overlay {
            switch homeViewModel.dataState {
            case .isLoading:
                LoadingOverlay()
            case .error(let error):
                ErrorOverlay(message: error) {
                    Task {
                        await homeViewModel.fetchWeaatherData(
                            lat: "\(locationManager.latitude)",
                            lon: "\(locationManager.longitude)",
                            onSuccess: { data in self.weatherResponse = data },
                            onFailure: { print("Error: \($0)") }
                        )
                    }
                }
            default:
                EmptyView()
            }
        }
        .task{
            await homeViewModel.fetchWeaatherData(
                lat: locationManager.latitude.description,
                lon: "\(locationManager.longitude)",
                onSuccess:{ data in
                    self.weatherResponse = data
                    self.hourlyForecasts = data.hourly ?? []
                    self.dailyForecasts = Array((data.daily ?? []).dropFirst())
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
