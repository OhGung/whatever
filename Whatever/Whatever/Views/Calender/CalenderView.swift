//
//  CalenderView.swift
//  Whatever
//
//  Created by chaekie on 2023/06/13.
//

import SwiftUI

struct TimeRecord {
    var startDate: Date
    var endDate: Date
}

struct CalenderView: View {
    @Environment(\.dismiss) private var dismiss
    var records: FetchedResults<CycleLog>
    @State var timeRecords: [String] = [""]
    @State private var months: [Int] = []
    @State var isLoading = true
    
    @State var selectedYear = Calendar.current.component(.year, from: Date())
    @State var selectedMonth = Calendar.current.component(.month, from: Date())
    @State var selectedDay = Calendar.current.component(.day, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    let loadingCount = 5
    
    @State var cycleLog: CycleLog? = nil
//    @State var date: Date = Date()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("생리를 하고 있다면 매일 기록하세요")
                    .foregroundColor(Color.white)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 42)
            .background(Color.vividPurple.opacity(0.37))
            ScrollViewReader { scrollView in
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        ForEach(months, id: \.self) { month in
                            MonthlyView(month: month,
                                        timeRecords: timeRecords,
                                        selectedDay: $selectedDay,
                                        selectedMonth: $selectedMonth,
                                        selectedYear: $selectedYear
                                        
                                        )
                            .id(month)
                            .onAppear {
                                if month == months.last {
                                    prependPreviousMonths(loadingCount)
//                                    appendNextMonths(loadingCount)
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    timeRecords = refineRecords()
                    appendCurrentMonth()
                }
                .onChange(of: selectedYear) { newValue in
                    cycleLog = getSelectedDateCycleLog()
//                    date = convertToDate()
                }
                .onChange(of: selectedMonth) { newValue in
                    cycleLog = getSelectedDateCycleLog()
//                    date = convertToDate()
                }
                .onChange(of: selectedDay) { newValue in
                    cycleLog = getSelectedDateCycleLog()
//                    date = convertToDate()
                    print("fffff", date, cycleLog)
                }
            }
            
            NavigationLink(destination: LogAddView(
                viewModel: LogAddViewModel(cycleLog: cycleLog, date: date)
            )) {
                Text("다음")
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.vividPurple)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
//            Button(action: {
//                print("다음", selectedYear, selectedMonth, selectedDay)
//                print(convertToDate())
//            }) {
//                Text("다음")
//                    .foregroundColor(Color.white)
//                    .font(.title3)
//                    .bold()
//                    .frame(maxWidth: .infinity, maxHeight: 50)
//                    .background(Color.vividPurple)
//                    .cornerRadius(12)
//                    .padding(.horizontal)
//            }
        }
        .clipped()
        .navigationTitle("오늘의 생리 기록")
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss.callAsFunction()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color.vividPurple)
                })
            }
        }
    }
    
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print("convertToDate", selectedYear, newMonth, selectedDay)
        
        return dateFormatter.date(from: "\(selectedYear)-\(String(format: "%02d", newMonth))-\(String(format: "%02d", selectedDay))")!
    }

    func getSelectedDateCycleLog() -> CycleLog? {
        let selectedDate = "\(selectedYear)-\(String(format: "%02d", newMonth))-\(String(format: "%02d", selectedDay))"
        var result: CycleLog?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for record in records {
            let date = dateFormatter.string(from: record.wrappedDate)
            if date.prefix(10) == selectedDate {
                result = record
                break
            }
        }
        return result
    }
    
    func refineRecords() -> [String] {
        var timeRecords: [String] = []
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR_POSIX")
        dateFormatter.dateFormat = "YYYY-MM-dd"
        for record in records {
            let date = dateFormatter.string(from: record.wrappedDate)
            timeRecords.append(date)
        }
        return timeRecords
    }
    
    var newMonth: Int {
        switch selectedMonth {
        case 1...12:
            return selectedMonth
        case 13...:
            return selectedMonth % 12 == 0 ? 12 : selectedMonth % 12
        default:
            return 12 + selectedMonth % 12
        }
    }
    
    func appendCurrentMonth() {
        months.append(currentMonth)
    }
    
    func appendNextMonths(_ count: Int) {
        if let lastMonth = months.last {
            for i in 1...count {
                let newMonth = lastMonth + i
                months.append(newMonth)
            }
        }
    }
    
    func prependPreviousMonths(_ count: Int) {
        if let firstMonth = months.last {
            for i in 1...count {
                let newMonth = firstMonth - i
                months.append(newMonth)
            }
        }
    }
    
    struct MonthlyView: View {
        var month: Int
        var newMonth: Int {
            switch month {
            case 1...12:
                return month
            case 13...:
                return month % 12 == 0 ? 12 : month % 12
            default:
                return 12 + month % 12
            }
        }
        
        var timeRecords: [String]
        @Binding var selectedDay: Int
        @Binding var selectedMonth: Int
        @Binding var selectedYear: Int
        @StateObject var customCalenderVM = CalendarViewModel()
        @State var dayInMonth = 30
        @State var startingDay = 0
        @State var isCurrentMonth = false
//        @State var yearGap = 0
//        @State private var newMonth = 0
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
        
        var body: some View {
            VStack {
                Text("\(String(customCalenderVM.currentYear + yearGap))년 \(newMonth)월")
                    .bold()
                    .foregroundColor(isCurrentMonth ? Color.black : Color.gray)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .font(.title2)
                
                CalenderDayView(isCurrentMonth: $isCurrentMonth)
                
                LazyVGrid(columns: columns, spacing: 22) {
                    ForEach(1...(dayInMonth + startingDay - 1), id: \.self) { item in
                        if item < startingDay {
                            Text("")
                        }
                        else {
                            let dayInt = item - startingDay + 1
                            if selectedYear == customCalenderVM.currentYear + yearGap
                                && selectedMonth == newMonth
                                && selectedDay == dayInt {
                                // selected
                                Text("\(dayInt)")
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .background(Circle().fill(Color.vividPurple)
                                        .frame(width: 40, height: 40))
                                    .onTapGesture {
                                        selectDay(dayInt)
                                    }
                            } else if checkRecordedDay(dayInt) {
                                // recorded
                                Text("\(dayInt)")
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .background(Circle().fill(Color.lightPurple)
                                        .frame(width: 40, height: 40))
                                    .onTapGesture {
                                        selectDay(dayInt)
                                    }
                            } else if isCurrentMonth && dayInt == customCalenderVM.currentDay {
                                // today
                                Text("\(dayInt)")
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.vividPurple)
                                    .overlay(alignment: .bottom) {
                                        Circle()
                                            .frame(width: 5, height: 5)
                                            .foregroundColor(Color.vividPurple)
                                            .offset(y: 5)
                                    }
                                    .onTapGesture {
                                        selectDay(dayInt)
                                    }
                            } else {
                                // default
                                Text("\(dayInt)")
                                    .onTapGesture {
                                        selectDay(dayInt)
                                    }
                            }
                        }
                    }
                }
                .padding()
            }.onAppear {
//                calculateNewMonth(month)
//                calculateYearGap(month)
                isCurrentMonth = month == customCalenderVM.currentMonth
                selectedMonth = customCalenderVM.currentMonth
                findDaysInMonth(month)
                
            }
        }
        
        func checkRecordedDay(_ dayInt: Int) -> Bool {
            
            var result: Bool = false
            for record in timeRecords {
                let startMonthIndex = record.index(record.startIndex, offsetBy: 5)
                let endMonthIndex = record.index(record.startIndex, offsetBy: 6)
                let startDayIndex = record.index(record.startIndex, offsetBy: 8)
                let endDayIndex = record.index(record.startIndex, offsetBy: 9)
                let yearSubstring = record.prefix(4)
                let monthSubstring = record[startMonthIndex...endMonthIndex]
                let daySubstring = record[startDayIndex...endDayIndex]
                
                if Int(daySubstring) == dayInt && Int(monthSubstring) == newMonth && Int(yearSubstring) == customCalenderVM.currentYear + yearGap {
                    result = true
                    break
                }
            }
            print(#function, newMonth, dayInt, timeRecords, result)
            return result
        }
        
        func selectDay(_ dayInt: Int) {
            selectedYear = customCalenderVM.currentYear + yearGap
            selectedMonth = month
            selectedDay = dayInt
//            cycleLog = getSelectedDateCycleLog()
//            date = convertToDate()
        }
        
        func findDaysInMonth(_ month: Int) {
            let calendar = Calendar.current
            let difference = month - customCalenderVM.currentMonth
            let someMonth = calendar.date(byAdding: .month, value: difference, to: Date())
            startingDay = customCalenderVM.findWeekdayName(date: someMonth!)
            let interval = calendar.dateInterval(of: .month, for: someMonth!)!
            self.dayInMonth = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        }
        
//        func calculateNewMonth(_ month: Int) {
//            if month > 12 {
//                newMonth = month % 12 == 0 ? 12 : month % 12
//            } else if month < 1 {
//                newMonth = 12 + month % 12
//            } else {
//                newMonth = month
//            }
//        }
        
        var yearGap: Int {
            if month < 0 {
                return month / 12 - 1
            } else if month % 12 == 0 {
                return month / 12 - 1
            } else {
                return month / 12
            }
        }
    }
}



//struct CalenderView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalenderView(record)
//    }
//}
