//
//  LocationsProtocols.swift
//  Weather
//
//  Created by Fatih Çimen on 22.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationsDelegate {
    func controller(_ controller: LocationsViewController, didSelectLocation location: Location)
}

protocol LocationsProtocol {
    var cityName: String { get }
    var temperature: String { get }
}
