//
//  Forecast.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    let list: [List]
}

struct List: Codable {
    let main: Main
    let weather: [Weather]
    private let dtTxt: String
    
    var date: Date {
        return stringToDateConvert(date: dtTxt, format: "yyyy-MM-dd HH:mm:ss")
    }
    
    enum CodingKeys: String, CodingKey {
        case weather, main
        case dtTxt = "dt_txt"
    }
}
