//
//  DailyWeather.swift
//  Majira
//
//  Created by Brandy Odhiambo on 13/07/2025.
//

import SwiftUI

struct DailyWeather: Codable {
    let dt: TimeInterval
    let sunrise: TimeInterval
    let sunset: TimeInterval
    let moonrise: TimeInterval
    let moonset: TimeInterval
    let moonPhase: Double
    let summary: String
    let temp: Temperature
    let feelsLike: FeelsLike
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case summary, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, rain, uvi
    }


    var day: String {
        let date = Date(timeIntervalSince1970: dt)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }

    var dateString: String {
        let date = Date(timeIntervalSince1970: dt)
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter.string(from: date)
    }

    var iconName: String {
        Utils.shared.mapIconToSFImage(icon: weather.first?.icon ?? "01d")
    }

    var temperatureString: String {
        "\(Utils.shared.kelvinToCelsiusString(temp.max)) / \(Utils.shared.kelvinToCelsiusString(temp.min))"
    }

    var weatherColor: Color {
        Utils.shared.weatherColor(for: weather.first?.main ?? "")
    }
}



