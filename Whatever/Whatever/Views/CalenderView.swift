//
//  CalenderView.swift
//  Whatever
//
//  Created by chaekie on 2023/06/13.
//

import SwiftUI

struct CalenderView: View {
    @State private var months: [Int] = []
    @State var selectedYear = Calendar.current.component(.year, from: Date())
    @State var selectedMonth = Calendar.current.component(.month, from: Date())
    @State var selectedDay = Calendar.current.component(.day, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    let loadingCount = 5
        
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
                                        selectedDay: $selectedDay,
                                        selectedMonth: $selectedMonth,
                                        selectedYear: $selectedYear)
                            .id(month)
                            .onAppear {
                                if month == months.last {
                                    appendNextMonths(loadingCount)
                                    //                                    print(month, months)
                                }
                            }
                        }
                    }
                }
                .clipped()
                .onAppear {
                    appendCurrentMonth(currentMonth)
                    scrollView.scrollTo(currentMonth, anchor: .top)
                }
            }
            Button(action: {
                let newMonth = calculateMonth()
                print("\(selectedYear)-\(String(format: "%02d", newMonth))-\(String(format: "%02d", selectedDay))")
            }) {
                Text("다음")
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.vividPurple)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            
        }
    }

    
    func calculateMonth() -> Int {
        if selectedMonth > 12 {
            return selectedMonth % 12 == 0 ? 12 : selectedMonth % 12
        } else if selectedMonth < 1 {
            return 12 + selectedMonth % 12
        } else {
            return selectedMonth
        }
    }
    
    func appendCurrentMonth(_ currentMonth: Int) {
        //        for i in (currentMonth - 12)...currentMonth {
        //            months.append(i)
        //        }
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
        if let firstMonth = months.first {
            for i in 1...count {
                let newMonth = firstMonth - i
                months.insert(newMonth, at: 0)
            }
        }
    }
    
    struct MonthlyView: View {
        var month: Int
        @Binding var selectedDay: Int
        @Binding var selectedMonth: Int
        @Binding var selectedYear: Int
        @StateObject var customCalenderVM = CalendarViewModel()
        @State var dayInMonth = 30
        @State var startingDay = 0
        @State var isCurrentMonth = false
        @State var yearGap = 0
        @State private var newMonth = 0
        
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
                            if customCalenderVM.currentYear + yearGap == selectedYear && month == selectedMonth && dayInt == selectedDay {
                                // selected
                                Text("\(dayInt)")
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .background(Circle().fill(Color.vividPurple)
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
                                // recorded
                                //Text("\(dayInt)")
                                //.foregroundColor(Color.white)
                                //.background(Circle().fill(Color.lightPurple)
                                //.frame(width: 40, height: 40))
                            }
                        }
                    }
                }
                .padding()
            }.onAppear {
                calculateNewMonth(month)
                calculateYearGap(month)
                isCurrentMonth = month == customCalenderVM.currentMonth
                selectedMonth = customCalenderVM.currentMonth
                findDaysInMonth(month)
            }
        }
        
        func selectDay(_ dayInt: Int) {
            selectedYear = customCalenderVM.currentYear + yearGap
            selectedMonth = month
            selectedDay = dayInt
        }
        
        func findDaysInMonth(_ month: Int) {
            let calendar = Calendar.current
            let difference = month - customCalenderVM.currentMonth
            let someMonth = calendar.date(byAdding: .month, value: difference, to: Date())
            startingDay = customCalenderVM.findWeekdayName(date: someMonth!)
            let interval = calendar.dateInterval(of: .month, for: someMonth!)!
            self.dayInMonth = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        }
        
        func calculateNewMonth(_ month: Int) {
            if month > 12 {
                newMonth = month % 12 == 0 ? 12 : month % 12
            } else if month < 1 {
                newMonth = 12 + month % 12
            } else {
                newMonth = month
            }
        }
        
        func calculateYearGap(_ month: Int) {
            if month < 0 {
                yearGap = month / 12 - 1
            } else if month % 12 == 0 {
                yearGap = month / 12 - 1
            } else {
                yearGap = month / 12
            }
        }
    }
}



struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalenderView()
    }
}
