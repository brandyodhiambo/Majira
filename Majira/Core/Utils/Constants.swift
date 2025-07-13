//
//  Constants.swift
//  Majira
//
//  Created by Brandy Odhiambo on 03/07/2025.
//

import Foundation

class Constants {
    static let timeoutInterval: Double = 45
    static let BASE_URL: String = "https://api.openweathermap.org"
    static let prefix: String = "/data/3.0/"
    static let weather: String = "\(prefix)/onecall"
    
    static let APP_NAME = "Majira"
    
    
    enum APIEdpoint {
        case allData(
            lat: String,
            lon: String,
            apiId: String
        )
        case excludeAlert(
            lat: String,
            lon: String,
            exclude: String,
            apiId: String
        )
        
        var url: URL? {
            switch self {
            case .allData(
                lat: let lat,
                lon: let lon,
                apiId: let apiId
            ):
                return URL(string: "\(BASE_URL)\(weather)?lat=\(lat)&lon=\(lon)&appid=\(apiId)")
            
            case .excludeAlert(
                let lat,
                let lon,
                let exclude,
                let apiId
            ):
                return URL(string: "\(BASE_URL)\(weather)?lat=\(lat)&lon=\(lon)&exclude=\(exclude)&appid=\(apiId)")
            }
        }
    }
}
