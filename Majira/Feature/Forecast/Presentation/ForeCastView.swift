//
//  ForeCastView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct ForeCastView: View {
    @State var sampleForecaset: [ForeCastItem] = [
        ForeCastItem(day: "Wednesday", date: "25 July", temperature: "23°", iconName: "sun.max.fill", weatherColor: .theme.sunnyYellow),
        ForeCastItem(day: "Thursday", date: "26 July", temperature: "24°", iconName: "cloud.sun.fill", weatherColor: .theme.cloudColor),
        ForeCastItem(day: "Friday", date: "27 July", temperature: "20°", iconName: "cloud.rain.fill", weatherColor: .theme.rainColor),
    ]
    var body: some View {
        let now = Date()
        let hours = (-2...2).map { Calendar.current.date(byAdding: .hour, value: $0, to: now)! }
        VStack(spacing:16){
            VStack(alignment:.leading, spacing:16){
                Text("Today's Forecast")
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
            .padding([.top, .leading], 12)
            
            VStack(alignment:.leading, spacing:16){
                Text("Next Forecasts")
                    .font(.custom("Poppins-Medium", size: 16))
                    .foregroundColor(.theme.onSurfaceColor.opacity(0.8))
                
                ScrollView(.vertical,showsIndicators: false){
                    VStack(spacing: 12) {
                        ForEach(sampleForecaset, id: \.day) { forecast in
                            ForecastRowView(
                                day: forecast.day,
                                date: forecast.date,
                                icon: forecast.iconName,
                                temperature: forecast.temperature,
                                weatherColor: forecast.weatherColor
                            )
                        }
                    }
                }
            }
            .padding([.top, .leading,.bottom], 12)
        }
        .background(Color.theme.surfaceColor)
        .customTopAppBar(
            title: "Forecast Report",
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
    NavigationView{
        ForeCastView()
    }
}
