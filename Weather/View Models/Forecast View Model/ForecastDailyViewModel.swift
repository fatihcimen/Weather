//
//  ForecastDailyViewModel.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

struct ForecastDailyViewModel: ForecastProtocol {
    
    let forecastDailyData: List
    
    private let timeFormatter = DateFormatter()
    
    // MARK: - Interface
    
    var forecastImageURL: URL {
        if let weatherIcon = forecastDailyData.weather.first?.icon {
            return URL(string: "https://openweathermap.org/img/w/\(weatherIcon).png")!
        }
        return URL(string: "https://fatihcimen.com/mobven/weather-alert.png")!
    }
    var time: String {
        timeFormatter.dateFormat = "HH:mm"
        
        return timeFormatter.string(from: forecastDailyData.date)
    }
    var temperature: String { return String(format: "%.0f°", forecastDailyData.main.temp) }
    
}
