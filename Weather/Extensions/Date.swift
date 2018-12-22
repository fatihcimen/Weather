//
//  Date.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

extension Date {
    
    func addDay(day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self)!
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var startOfDate: Date {
        return stringToDateConvert(date: "\(day).\(month).\(year) 00:00", format: "dd.MM.yyyy HH:mm")
    }
    
    var endOfDate: Date {
        return stringToDateConvert(date: "\(day).\(month).\(year) 23:59", format: "dd.MM.yyyy HH:mm")
    }
}
