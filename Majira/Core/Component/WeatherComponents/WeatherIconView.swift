//
//  WeatherIconView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct WeatherIconView: View {
    let systemName: String
    let size: CGFloat
    let weatherColor: Color

    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundColor(weatherColor)
    }
}

struct WeatherIconViewPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherIconView(systemName: "sun.max.fill", size: 150, weatherColor: Color.theme.sunnyYellow)
                .previewDisplayName("Sunny")

            WeatherIconView(systemName: "cloud.rain.fill", size: 60, weatherColor: Color.theme.rainColor)
                .previewDisplayName("Rainy")
            
            WeatherIconView(systemName: "cloud.snow.fill", size: 60, weatherColor: Color.theme.snowColor)
                .previewDisplayName("Snowy")
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .background(Color.theme.surfaceColor.opacity(0.2))
    }
}

