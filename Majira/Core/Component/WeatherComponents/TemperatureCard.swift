//
//  TemperatureCard.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct TemperatureCard: View {
    let temperature: String
    let iconName: String
    let date: Date
    var isSelected: Bool = false
    var weatherColor:Color = Color.theme.onSurfaceColor.opacity(0.7)

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(weatherColor)

            Text(temperature)
                .font(.custom("Poppins-ExtraBold", size: 20))
                .foregroundColor(isSelected ? Color.theme.onPrimaryColor : Color.theme.onSurfaceColor.opacity(0.9))

            Spacer(minLength: 2)

            Text(Utils.shared.timeLabel(for: date))
                .font(.custom("Poppins-Thin", size: 12))
                .foregroundColor(isSelected ? Color.theme.onPrimaryColor : Color.theme.onSurfaceColor.opacity(0.7))
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .frame(width: 100, height: 140)
        .background(isSelected ? Color.theme.primaryColor : Color.theme.surfaceColor.opacity(0.9))
        .cornerRadius(12)
        .shadow(color: .theme.onSurfaceColor.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}


struct TemperatureCardPreviews: PreviewProvider {
    static var previews: some View {
        let now = Date()
        let hours = (-2...2).map { Calendar.current.date(byAdding: .hour, value: $0, to: now)! }

        return Group {
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
            .previewDisplayName("Temperature Scroll")
            .preferredColorScheme(.light)

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
            .previewDisplayName("Temperature Scroll Dark")
            .preferredColorScheme(.dark)
        }
    }
}


