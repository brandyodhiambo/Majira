//
//  WeatherRepositoryImpl.swift
//  Majira
//
//  Created by Brandy Odhiambo on 13/07/2025.
//
import Foundation

struct WeatherRepositoryImpl: WeatherRepository {
    static let shared = WeatherRepositoryImpl()
    let weatherDataSource = WeatherDataSource()
    
    func fetchWeatherData(
        lat: String,
        lon: String
    ) async -> Result<WeatherResponse, NetworkError>{
        return await weatherDataSource.fetchWeatherData(lat: lat, lon: lon)
    }
}
