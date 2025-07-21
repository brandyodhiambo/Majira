//
//  CityRepository.swift
//  Majira
//
//  Created by MAC on 21/07/2025.
//

import Foundation


protocol CityRepository {
    func addCity(city: City) throws
    func getAllCities() throws -> [City]
    func getCityById(id: UUID) throws -> City?
    func updateCity(city: City) throws
    func deleteCityById(id:UUID) throws
    func deleteAllCities() throws
}
