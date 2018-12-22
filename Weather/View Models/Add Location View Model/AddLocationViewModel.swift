//
//  AddLocationViewModel.swift
//  Weather
//
//  Created by Fatih Çimen on 22.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation
import CoreLocation

struct AddLocationViewModel: AddLocationProtocol {
    
    // MARK: - Properties
    
    let location: Location
    
    var cityName: String {
        return location.cityName
    }
}
