//
//  CityViewModel.swift
//  Majira
//
//  Created by MAC on 21/07/2025.
//

import Foundation


@MainActor
class CityViewModel:ObservableObject {
    @Published var cities:[City] = []
    @Published var city:City? = nil
    private let repo:CityRepository = CityRepositoryImpl.shared
    
    func loadCities() {
        do {
            cities = try repo.getAllCities()
        } catch {
            print("Failed to load: \(error)")
        }
    }
    
    
    func loadCity(id: UUID) {
        print("Trying to load city with ID: \(id)")
        do {
            let loadedCity = try repo.getCityById(id: id)
            print("Found city: \(loadedCity?.city ?? "nil")")
            self.city = loadedCity
        } catch {
            print("Failed to load task: \(error)")
        }
    }
    
    
    
    func addCity(city:City) {
        do {
            try repo.addCity(city: city)
            loadCities()
        } catch {
            print("Create failed: \(error)")
        }
    }
    
    func deleteCityById(id:UUID) {
        do {
            try repo.deleteCityById(id:id)
            loadCities()
        } catch {
            print("Delete failed: \(error)")
        }
    }
    
    func deleteAllCities() {
        do {
            try repo.deleteAllCities()
            loadCities()
        } catch {
            print("Delete failed: \(error)")
        }
    }
    
    func updateCity(_ city: City) {
        do {
            try repo.updateCity(city: city)
            loadCities()
        } catch {
            print("Update failed: \(error)")
        }
    }
}
