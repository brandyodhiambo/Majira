//
//  CityWeatherDetailsView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct CityWeatherDetailsView: View {
    @EnvironmentObject var router:Router
    
    let city: City
    var body: some View {
        VStack {
            Text(city.cityName)
                .font(.headline)
            Text("\(city.temperature)°C")
        }
        .padding()
        .background(Color.theme.surfaceColor)
        .customTopAppBar(
            title: "",
            leadingIcon: "chevron.left",
            navbarTitleDisplayMode: .inline,
            onLeadingTap: {
                router.pop()
            },
            trailingIcon: "moon.fill",
            onTrailingTap: {
                
            }
        )
    }
}

#Preview {
    CityWeatherDetailsView(
        city:City.preview
    )
}
