//
//  CalendarViewModel.swift
//  Whatever
//
//  Created by chaekie on 2023/06/13.
//

import Foundation

class CalendarViewModel : ObservableObject {
    @Published var currentYear = Calendar.current.component(.year, from: Date())
    @Published var currentMonth = Calendar.current.component(.month, from: Date())
    @Published var currentDay = Calendar.current.component(.day, from: Date())
    
    func findWeekdayName(date : Date) -> Int {
        return date.firstDayOfTheMonth.weekday
    }
}
