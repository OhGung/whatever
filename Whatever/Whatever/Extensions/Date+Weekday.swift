//
//  Date+Weekday.swift
//  Whatever
//
//  Created by chaekie on 2023/06/13.
//

import Foundation

extension Date {
//    var year: Int { Calendar.current.component(.year, from: self) }
    var weekday: Int { Calendar.current.component(.weekday, from: self) }
    var firstDayOfTheMonth: Date {
        Calendar.current.dateComponents([.calendar, .year,.month], from: self).date!
    }
}

extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
       String.dateFormatter.date(from: self)
    }
}
