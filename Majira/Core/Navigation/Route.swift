//
//  Route.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import Foundation

enum Route:Hashable {
    case landingPage
    case home
    case forecast
    case city
    case cityDetails(city:CityWeather)
}
