//
//  City.swift
//  Majira
//
//  Created by Brandy Odhiambo on 08/07/2025.
//
import SwiftUI
import Foundation

struct City: Hashable, Equatable {
    let id: UUID = UUID()
    let cityName: String
    let temperature: String
    let iconName: String
    let weatherColor:Color
}

extension City {
    static let preview: City = City(
        cityName: "Nairobi",
        temperature: "25°",
        iconName: "cloud.sun.fill",
        weatherColor: .theme.sunnyYellow
    )
}


