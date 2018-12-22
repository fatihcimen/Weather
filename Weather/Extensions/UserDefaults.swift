//
//  UserDefaults.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

enum Unit: Int {
    case imperial
    case metric
}

enum Temperature: Int {
    case celsius
    case fahrenheit
}

struct UserDefaultsKeys {
    static let locations = "locations"
    static let unit = "unit"
    static let temperature = "temperature"
}

// MARK: - Settings Conversions

extension UserDefaults {
    
    // MARK: - Unit
    
    static func getUnit() -> Unit {
        let value = UserDefaults.standard.integer(forKey: UserDefaultsKeys.unit)
        return Unit(rawValue: value) ?? .metric
    }
    
    static func setUnit(unit: Unit) {
        UserDefaults.standard.set(unit.rawValue, forKey: UserDefaultsKeys.unit)
    }
    
    // MARK: - Temperature
    
    static func getTemperature() -> Temperature {
        let value = UserDefaults.standard.integer(forKey: UserDefaultsKeys.temperature)
        return Temperature(rawValue: value) ?? .celsius
    }
}

// MARK: - Location

extension UserDefaults {
    
    // MARK: - Locations CRUD
    
    static func addLocation(location: Location) {
        var locations = getLocations()
        locations.append(location)
        saveLocations(locations: locations)
    }
    
    
    static func getLocations() -> [Location] {
        guard let dictionary = UserDefaults.standard.array(forKey: UserDefaultsKeys.locations) as? [[String: Any]] else { return [] }
        
        return dictionary.compactMap({ dictionary -> Location? in
            return Location(dictionary: dictionary)
        })
    }
    
    static func saveLocations(locations: [Location]) {
        let locationsDictionary: [[String: Any]] = locations.map{ $0.toDictionary }
        
        UserDefaults.standard.set(locationsDictionary, forKey: UserDefaultsKeys.locations)
    }
    
    static func deleteLocation(location: Location) {
        var locations = getLocations()
        
        guard let index = locations.index(of: location) else { return }
        
        locations.remove(at: index)
        
        saveLocations(locations: locations)
    }
    
    static func deleteAllLocations() {
        saveLocations(locations: [])
    }
}
