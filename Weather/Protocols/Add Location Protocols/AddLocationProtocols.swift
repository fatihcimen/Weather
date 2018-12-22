//
//  AddLocationProtocols.swift
//  Weather
//
//  Created by Fatih Çimen on 22.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

protocol AddLocationDelegate {
    func controller(_ controller: AddLocationViewController, didAddLocation location: Location)
}

protocol AddLocationProtocol {
    var cityName: String { get }
}
