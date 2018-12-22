//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

struct ForecastViewModel {
    
    // MARK: - Properties
    
    var forecastData: Forecast
    
    var date: Date = Date()
    
    // MARK - Daily Forecast Data
    
    func forecastDailyDataList() -> [List] {
        return forecastData.list.filter { $0.date >= date.startOfDate && $0.date <= date.endOfDate }
    }
    
    // MARK: - CollectionView Cell View Model
    
    func viewModel(for index: Int) -> ForecastDailyViewModel {
        return ForecastDailyViewModel(forecastDailyData: forecastDailyDataList()[index])
    }
}

// MARK: - Collection View Data Source Elements

extension ForecastViewModel {
    var numberOfSections: Int { return 1 }
    var numberOfForecast: Int { return forecastDailyDataList().count }
}
