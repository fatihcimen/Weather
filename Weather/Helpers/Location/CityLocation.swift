//
//  CityLocation.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import CoreLocation

// MARK: - Latitude Longitude to City
public func city(fromCLLocation currentLocation: CLLocation, completionHandler: @escaping(String) -> ()) {
    let geocode = CLGeocoder()
    geocode.reverseGeocodeLocation(currentLocation) { placemarks, error in
        guard let placemark = placemarks?.first else { return }
        
        if let city = placemark.administrativeArea {
            completionHandler(city)
        }else {
            completionHandler(Defaults.city)
        }
    }
}
