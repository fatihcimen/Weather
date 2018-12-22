//
//  CurrentWeather.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

struct CurrentWeather: Codable {
    
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let id: Int
    let name: String
}

struct Coord: Codable {
    let lon, lat: Double
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}
