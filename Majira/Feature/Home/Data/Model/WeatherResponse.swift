//
//  WeatherResponse.swift
//  Majira
//
//  Created by Brandy Odhiambo on 13/07/2025.
//

import Foundation

struct WeatherResponse: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: CurrentWeather
    var minutely: [MinutelyForecast]? = nil
    var hourly: [HourlyForecast]? = nil
    var daily: [DailyWeather]? = nil

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely, hourly, daily
    }
}
