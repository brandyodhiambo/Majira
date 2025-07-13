//
//  WeatherRepository.swift
//  Majira
//
//  Created by Brandy Odhiambo on 13/07/2025.
//
import Foundation

protocol WeatherRepository{
    func fetchWeatherData(
        lat: String,
        lon: String
    ) async -> Result<WeatherResponse, NetworkError>
}
