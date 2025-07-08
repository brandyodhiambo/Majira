//
//  HomeView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        let now = Date()
        let hours = (-2...2).map { Calendar.current.date(byAdding: .hour, value: $0, to: now)! }
        
        ScrollView(.vertical,showsIndicators: false){
            VStack(alignment:.leading,spacing:16){
                // Upper Part
                VStack(alignment:.center, spacing:16){
                   LocationHeaderView(location: "Nairobi, Kenya")
                   WeatherIconView(image: "sunRain", size: 150, weatherColor: Color.theme.sunnyYellow)
                   Text("Tuesday, 8th July")
                       .font(.custom("Poppins-Medium", size: 16))
                       .foregroundColor(.theme.onSurfaceColor)
                   Text("29°C")
                       .font(.custom("Poppins-ExtraBold", size: 30))
                       .foregroundColor(Color.theme.onSurfaceColor.opacity(0.9))
                   
                   // weather condition
                   HStack (spacing:12){
                       Spacer()
                       WeatherConditionView(
                           icon: "wind", condition: "11km/h"
                       )
                       Spacer()
                       WeatherConditionView(
                           icon: "drop.fill", condition: "54%"
                       )
                       Spacer()
                       WeatherConditionView(
                           icon: "sun.max.fill", condition: "8hr"
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
                .padding()
                
            }
        }
        .background(Color.theme.surfaceColor)
        .customTopAppBar(
            title: "",
            leadingIcon: "",
            navbarTitleDisplayMode: .inline,
            onLeadingTap: {},
            trailingIcon: "moon.fill",
            onTrailingTap: {
               
            }
        )
       
    }
    
    
}



#Preview {
    NavigationView {
        HomeView()
    }
}
