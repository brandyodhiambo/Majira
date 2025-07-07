//
//  WeatherIconView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct WeatherIconView: View {
    let image: String
    let size: CGFloat
    let weatherColor: Color

    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundColor(weatherColor)
    }
}

struct WeatherIconViewPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherIconView(image: "sun", size: 200, weatherColor: Color.theme.sunnyYellow)
                .previewDisplayName("Sunny")

            WeatherIconView(image: "rain", size: 200, weatherColor: Color.theme.rainColor)
                .previewDisplayName("Rainy")
            
            WeatherIconView(image: "snow", size: 200, weatherColor: Color.theme.snowColor)
                .previewDisplayName("Snowy")
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .background(Color.theme.surfaceColor.opacity(0.2))
    }
}

