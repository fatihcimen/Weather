//
//  APIConfigurations.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

enum WeatherRequestType: String {
    case weather = "weather"
    case forecast = "forecast"
    case group = "group"
}

struct APIConfigurations {
    
    static let apiKey = "8827fbf408dc7e1418f3c1e84596334c"
    static let baseUrl = "http://api.openweathermap.org/data/2.5/"
}
