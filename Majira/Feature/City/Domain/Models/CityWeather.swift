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
    let sunDuration: String
    let humidity: String
    let windSpeed: String
    let weatherColor:Color
    let hourlyWeather: [HourlyForecast]?
}

extension CityWeather {
    static let preview: CityWeather = CityWeather(
        cityName: "Nairobi",
        temperature: "25°C",
        iconName: "sun.max.fill",
        condition: "Sunny",
        sunDuration: "12:00 - 18:00",
        humidity: "60",
        windSpeed: "10",
        weatherColor: .theme.sunnyYellow,
        hourlyWeather: nil
    )
}
