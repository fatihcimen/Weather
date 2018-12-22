//
//  DateHelper.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Foundation

private func stringToDateFormatter(format: String) -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = Locale.init(identifier: "tr_TR")
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    return dateFormatter
}

func stringToDateConvert(date: String, format: String) -> Date {
    let dateFormatter = stringToDateFormatter(format: format)
    return dateFormatter.date(from: date)!
}
