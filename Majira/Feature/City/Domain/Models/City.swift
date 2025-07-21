//
//  City.swift
//  Majira
//
//  Created by Brandy Odhiambo on 08/07/2025.
//
import Foundation

struct City: Identifiable, Hashable, Equatable {
    var id: UUID
    var city: String
    var latitude: Double
    var longitude: Double
    
    static func from(entity: CityEntity) -> City {
        return City(
            id: entity.id ?? UUID(),
            city: entity.city ?? "",
            latitude: entity.lat,
            longitude: entity.lon
        )
    }
}


