//
//  WeatherUseCase.swift
//  Majira
//
//  Created by Brandy Odhiambo on 13/07/2025.
//
import Foundation

struct WeatherUseCase {
    let weatherRepository: WeatherRepository
    
    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }
    
    func executeFetchWeatherData(lat:String,lon:String) async -> Result<WeatherResponse, NetworkError> {
        return await weatherRepository.fetchWeatherData(lat: lat, lon: lon)
    }
}
