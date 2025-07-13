//
//  HomeViewModel.swift
//  Majira
//
//  Created by Brandy Odhiambo on 13/07/2025.
//

import Foundation


@MainActor
class HomeViewModel:ObservableObject{
    @Published var dataState = DataState.good
    var weatherUseCase = WeatherUseCase(weatherRepository: WeatherRepositoryImpl.shared)
    
    func fetchWeaatherData(
        lat:String,
        lon:String,
        onSuccess:@escaping (WeatherResponse)->Void,
        onFailure:@escaping (String)->Void
    ) async {
        dataState = .isLoading
        
        let results = await weatherUseCase.executeFetchWeatherData(lat: lat, lon: lon)
        switch results {
        case .success(let response):
            dataState = .good
            onSuccess(response)
            print("DEBUG: fetched Weather: \(response.current), daily count \(response.daily.count)" )
        case .failure(let error):
            dataState = .error(error.description)
            print("DEBUG: fetched failed chef: \(error.description)" )
            onFailure(error.localizedDescription)
        }
    }
}
