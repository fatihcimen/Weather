//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

struct WeatherViewModel: WeatherProtocol {
    
    // MARK: - Properties
    
    let weatherData: CurrentWeather
    
    // MARK: - Interface
    
    var weatherImageURL: URL {
        if let weatherIcon = weatherData.weather.first?.icon {
            return URL(string: "https://openweathermap.org/img/w/\(weatherIcon).png")!
        }
        return URL(string: "https://fatihcimen.com/mobven/weather-alert.png")!
    }
    
    var description: String {
        if let weatherDescription = weatherData.weather.first?.description {
            return weatherDescription
        }
        return "weatherDataCannotFetched".localized
    }
    
    var temperature: String {
        switch UserDefaults.getTemperature() {
        case .celsius: return String(format: "%.0f °C", weatherData.main.temp)
        case .fahrenheit: return String(format: "%.0f °F", weatherData.main.temp)
        }
    }
}
