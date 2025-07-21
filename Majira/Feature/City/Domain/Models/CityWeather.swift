//
//  CityWeather.swift
//  Majira
//
//  Created by MAC on 21/07/2025.
//

import SwiftUI
import Foundation

struct CityWeather: Hashable, Equatable {
    let id: UUID = UUID()
    let cityName: String
    let temperature: String
    let iconName: String
    let condition: String
    let weatherColor:Color
}

extension CityWeather {
    static let preview: CityWeather = CityWeather(
        cityName: "Nairobi",
        temperature: "25°C",
        iconName: "sun.max.fill",
        condition: "Sunny",
        weatherColor: .theme.sunnyYellow
    )
}
