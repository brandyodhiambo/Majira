//
//  WeatherIconView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct WeatherIconView: View {
    let iconCode: String
    let size: CGFloat

    var body: some View {
        Utils.shared.weatherImage(for: iconCode)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

struct WeatherIconViewPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherIconView(iconCode: "01d", size: 200)
                .previewDisplayName("Sunny")

            WeatherIconView(iconCode: "09d", size: 200)
                .previewDisplayName("Rainy")
            
            WeatherIconView(iconCode: "13d", size: 200)
                .previewDisplayName("Snowy")
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .background(Color.theme.surfaceColor.opacity(0.2))
    }
}

