//
//  WeatherProtocols.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

protocol WeatherProtocol {
    
    var weatherImageURL: URL { get }
    var description: String { get }
    var temperature: String { get }
}
