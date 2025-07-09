//
//  CityCardView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct CityCardView: View {
    let cityName: String
    let temperature: String
    let iconName: String
    let weatherColor: Color
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                Text(cityName)
                    .font(.custom("Poppins-Medium", size: 18))
                    .foregroundColor(.theme.onSurfaceColor)

                Spacer()
                HStack(spacing: 8) {
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(weatherColor)

                    Text(temperature)
                        .font(.custom("Poppins-SemiBold", size: 20))
                        .foregroundColor(.theme.onSurfaceColor)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.theme.surfaceColor)
            .cornerRadius(12)
            .shadow(color: Color.theme.onSurfaceColor.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}



struct CityCardViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 12) {
            CityCardView(cityName: "Nairobi", temperature: "25°", iconName: "sun.max.fill",weatherColor: .theme.sunnyYellow,onTap: {})
            CityCardView(cityName: "Kisumu", temperature: "28°", iconName: "cloud.sun.fill",weatherColor: Color.theme.cloudColor,onTap: {})
            CityCardView(cityName: "Mombasa", temperature: "30°", iconName: "cloud.bolt.rain.fill",weatherColor: Color.theme.rainColor,onTap: {})
        }
        .padding()
        .background(Color.theme.surfaceColor)
        .previewLayout(.sizeThatFits)
    }
}
