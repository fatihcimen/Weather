//
//  ForecastProtocols.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

protocol ForecastProtocol {
    
    var forecastImageURL: URL { get }
    var time: String { get }
    var temperature: String { get }
}
