//
//  WeatherDataSource.swift
//  Majira
//
//  Created by Brandy Odhiambo on 13/07/2025.
//

import Foundation

struct WeatherDataSource {
    func fetchWeatherData(
        lat: String,
        lon: String
    ) async -> Result<WeatherResponse,NetworkError>{
        guard let url = Constants.APIEdpoint.allData(lat: lat, lon: lon, apiId: "a2b4be21d2ad97df907367e55e77a9e3").url else {
            return .failure(NetworkError.badURL)
        }
        
        let (responseData, response) = await NetworkUtils.shared.makeAPIRequest(url: url, httpMethod: .GET)
        
        do {
            
            guard let data = responseData else {
                return .failure(NetworkError.unexpected)
            }
            
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let httpResponse = response as? HTTPURLResponse, 400..<499 ~= httpResponse.statusCode {
                    guard  let apiErrorMessage = json["message"] as? String else {
                        let errorMessage: String = json["message"] as? String ?? "Something went wrong while fetching weather data!"
                        return .failure(NetworkError.custom(errorMessage))
                    }
                    return .failure(NetworkError.unexpected)
                }
            }
            
            let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return .success(decodedData)
        }
        catch let decodingError as DecodingError {
            print("DEBUG: fetchweather decoding error \(decodingError)")
            return .failure(NetworkError.custom("We are unable to fetch weather data, kindly try again."))
        } catch {
            print("Request failed: \(error)")
            return .failure(NetworkError.custom("We are unable to fetch weather data, kindly try again."))
        }
        
    }
}
