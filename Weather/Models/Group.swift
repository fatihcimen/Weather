//
//  Group.swift
//  Weather
//
//  Created by Fatih Çimen on 22.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

struct Group: Codable {
    let groupWeather: [GroupWeather]
    
    enum CodingKeys: String, CodingKey {
        case groupWeather = "list"
    }
}

struct GroupWeather: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
    let id: Int
}
