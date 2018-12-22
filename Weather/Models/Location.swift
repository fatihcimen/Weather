//
//  Location.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

struct Location {
    
    private enum Keys {
        static let id = "id"
        static let name = "name"
        static let lastTemp = "lastTemp"
    }
    
    var cityId: Int
    let cityName: String
    var lastTemp: Double
    
    var toDictionary: [String: Any] {
        return [Keys.id: cityId, Keys.name: cityName, Keys.lastTemp: lastTemp]
    }
}

extension Location {
    
    // MARK: - Initialize
    
    init?(dictionary: [String: Any]) {
        guard let cityId = dictionary[Keys.id] as? Int else { return nil }
        guard let cityName = dictionary[Keys.name] as? String else { return nil }
        guard let lastTemp = dictionary[Keys.lastTemp] as? Double else { return nil }
        
        self.cityId = cityId
        self.cityName = cityName
        self.lastTemp = lastTemp
    }
}

extension Location: Equatable {
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.cityId == rhs.cityId && lhs.cityName == rhs.cityName && lhs.lastTemp == rhs.lastTemp
    }
}
