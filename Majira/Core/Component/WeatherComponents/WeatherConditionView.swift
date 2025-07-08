//
//  WeatherConditionView.swift
//  Majira
//
//  Created by MAC on 08/07/2025.
//

import SwiftUI

struct WeatherConditionView: View {
    let icon: String
    let condition: String
    var body: some View {
        HStack(spacing:4) {
            Image(systemName: icon)
                .foregroundColor(.theme.onSurfaceColor)
            Text(condition)
                .font(.custom("Poppins-Thin", size: 12))
        }
    }
}

#Preview {
    WeatherConditionView(
        icon: "sun.max.fill", condition: "Sunny"
    )
}
