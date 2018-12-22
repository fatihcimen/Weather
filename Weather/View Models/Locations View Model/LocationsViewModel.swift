//
//  LocationsViewModel.swift
//  Weather
//
//  Created by Fatih Çimen on 22.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationsViewModel: LocationsProtocol {
    
    let locationData: Location
    
    // MARK: - Properties
    
    var cityName: String {
        return locationData.cityName
    }
    
    var temperature: String {
        switch UserDefaults.getTemperature() {
        case .celsius: return String(format: "%.0f °C", locationData.lastTemp)
        case .fahrenheit: return String(format: "%.0f °F", locationData.lastTemp)
        }
    }
}
