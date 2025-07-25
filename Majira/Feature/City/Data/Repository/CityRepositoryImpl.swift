//
//  CityRepositoryImpl.swift
//  Majira
//
//  Created by MAC on 21/07/2025.
//
import Foundation
import CoreData


class CityRepositoryImpl: CityRepository {
    private let context = CoreDataStack.shared.persistentContainer.viewContext

    static let shared = CityRepositoryImpl()
    
    func addCity(city: City) throws {
        let newCity = CityEntity(context: context)
        newCity.id = city.id
        newCity.city = city.city
        newCity.lat = city.latitude
        newCity.lon = city.longitude
        try context.save()
    }
    
    func getAllCities() throws -> [City] {
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        let result = try context.fetch(fetchRequest)
        return result.map{City.from(entity: $0)}
        
    }
    
    func getCityById(id: UUID) throws -> City? {
        let cities = try getAllCities()
        let city = cities.filter { $0.id == id }.first
        guard let cityUnrwapped = city else {
            print("No city found for ID: \(id)")
            return nil
        }
        
        return cityUnrwapped
    }
    
    
    func updateCity(city: City) throws {
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", city.id as CVarArg)
        guard let cityEntity = try context.fetch(fetchRequest).first else {
            return
        }
        cityEntity.id = city.id
        cityEntity.city = city.city
        cityEntity.lat = city.latitude
        cityEntity.lon = city.longitude
        try context.save()
    }
    
    func deleteCityByName(cityName: String) throws {
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "city == %@", cityName as CVarArg)
        if let entity = try context.fetch(fetchRequest).first {
            context.delete(entity)
            try context.save()
        }
    }
    
    func deleteAllCities() throws {
        let fetchRequest: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        let allEntities = try context.fetch(fetchRequest)
        for entity in allEntities {
            context.delete(entity)
        }
        try context.save()
    }
    
}
