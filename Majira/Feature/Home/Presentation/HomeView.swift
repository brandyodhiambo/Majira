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
    @State private var locationName: String = "Loading..."

    

    var body: some View {
        let now = Date()
        let hours = (-2...2).map { Calendar.current.date(byAdding: .hour, value: $0, to: now)! }
        
        ScrollView(.vertical,showsIndicators: false){
            VStack(alignment:.leading,spacing:16){
                // Upper Part
                VStack(alignment:.center, spacing:16){
                   LocationHeaderView(location: locationName)
                    
                   WeatherIconView(image: "sunRain", size: 150, weatherColor: Color.theme.sunnyYellow)
                    
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
                            ForEach(hours, id: \.self) { hour in
                                let isNow = Calendar.current.component(.hour, from: hour) == Calendar.current.component(.hour, from: now)

                                TemperatureCard(
                                    temperature: "\(Int.random(in: 22...28))°",
                                    iconName: isNow ? "sun.max.fill" : "cloud.sun.fill",
                                    date: hour,
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
        .overlay{
            Group{
                if homeViewModel.dataState == .isLoading{
                    ZStack{
                        Rectangle()
                            .opacity(0.3)
                            .foregroundColor(Color.black)
                        ProgressView()
                    }
                }
            }
        }
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
