//
//  CityWeatherDetailsView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct CityWeatherDetailsView: View {
    let id:Int
    var body: some View {
        Text("City weather details")
            .font(.title)
            .foregroundColor(.theme.onSurfaceColor)
            .padding()
    }
}

#Preview {
    CityWeatherDetailsView(
        id:1
    )
}
