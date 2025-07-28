//
//  CityWeatherDetailsView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct CityWeatherDetailsView: View {
    @EnvironmentObject var router:Router
    
    let city: CityWeather
    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment:.center,spacing: 12){
                HStack(spacing:2){
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.theme.onSurfaceColor)
                    Text(city.cityName)
                        .font(.custom("Poppins-ExtraBold", size: 25))
                        .padding()
                }
                
                Image(systemName: city.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(city.weatherColor)
        
                Text(city.temperature)
                   .font(.custom("Poppins-ExtraBold", size: 30))
                   .foregroundColor(Color.theme.onSurfaceColor.opacity(0.9))
                
                Text(city.condition)
                   .font(.custom("Poppins-Medium", size: 18))
                   .foregroundColor(Color.theme.onSurfaceColor.opacity(0.9))
               
               // weather condition
               HStack (spacing:12){
                   Spacer()
                   WeatherConditionView(
                    icon: "wind", condition: "\(city.windSpeed)km/h"
                   )
                   Spacer()
                   WeatherConditionView(
                    icon: "drop.fill", condition: "\(city.humidity)%"
                   )
                   Spacer()
                   WeatherConditionView(
                    icon: "sun.max.fill", condition: "\(city.sunDuration)hr"
                   )
                   Spacer()
               }
            }
            .padding()
            .background(
                Rectangle()
                    .fill(city.weatherColor.opacity(0.4))
                    .clipShape(RoundedCorner(radius: 60, corners: [.bottomLeft, .bottomRight]))
                    .frame(maxWidth: .infinity, maxHeight: 700)
                    .edgesIgnoringSafeArea(.top)
            )
           
            //downer part
            VStack(alignment:.leading, spacing:16){
                Text("Today's Forecast")
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundColor(.theme.onSurfaceColor.opacity(0.7))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(city.hourlyWeather ?? [], id: \.dt) { forecast in
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
            .padding()
            
            Spacer()
        }
        .background(Color.theme.surfaceColor)
        .customTopAppBar(
            title: "",
            leadingIcon: "chevron.left",
            navbarTitleDisplayMode: .inline,
            onLeadingTap: {
                router.pop()
            },
            trailingIcon: "",
            onTrailingTap: {
                
            }
        )
    }
}

#Preview {
    NavigationView {
        CityWeatherDetailsView(
            city:CityWeather.preview
        )
    }
}
