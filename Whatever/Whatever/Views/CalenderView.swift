//
//  CalenderView.swift
//  Whatever
//
//  Created by chaekie on 2023/06/13.
//

import SwiftUI

struct CalenderView: View {
    @State private var months: [Int] = []
    @State var selectedMonth = 0
    @State var selectedDay = 0
    var currentMonth = Calendar.current.component(.month, from: Date())
    let loadingCount = 5
    
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    ForEach((currentMonth - loadingCount)...(currentMonth + loadingCount),
                            id: \.self) { month in
                        MonthlyView(month: month,
                                    selectedDay: $selectedDay,
                                    selectedMonth: $selectedMonth)
                    }
                }
            }
            .clipped()
            .onAppear {
                scrollView.scrollTo(currentMonth, anchor: .top)
            }
        }
    }
    
    struct MonthlyView: View {
        var month: Int
        @Binding var selectedDay: Int
        @Binding var selectedMonth: Int
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
                    .padding(.top,20)
                
                CalenderDayView(isCurrentMonth: $isCurrentMonth)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(1...(dayInMonth + startingDay - 1), id: \.self) { item in
                        if item < startingDay {
                            Text("")
                        }
                        else {
                            let dayInt = item - startingDay + 1
                            if month == selectedMonth && dayInt == selectedDay {
                                getFocusedDay(dayInt, state: "selected")
                            } else if isCurrentMonth && dayInt == customCalenderVM.currentDay {
                                getFocusedDay(dayInt, state: "today")
                            } else {
                                getFocusedDay(dayInt, state: "")
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
        
        func findDaysInMonth(_ month: Int) {
            let calendar = Calendar.current
            let difference = month - customCalenderVM.currentMonth
            let someMonth = calendar.date(byAdding: .month, value: difference, to: Date())
            startingDay = customCalenderVM.findWeekdayName(date: someMonth!)
            let interval = calendar.dateInterval(of: .month, for: someMonth!)!
            self.dayInMonth = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
            
        }
        
        func getFocusedDayColor(_ state: String) -> Color {
            var color: Color
            switch state {
            case "today":
                color = Color.gray
            case "selected":
                color =  Color.purple
            default:
                color = Color.clear
            }
            return color
        }
        
        func getFocusedDay(_ dayInt: Int, state: String) -> some View {
            Text("\(dayInt)")
                .background(Circle().fill(getFocusedDayColor(state))
                    .frame(width: 40, height: 40))
                .onTapGesture {
                    selectedDay = dayInt
                    selectedMonth = month
                }
        }
        
        func calculateNewMonth(_ month: Int) {
            if month > 12 {
                newMonth = month % 12
            } else if month < 1 {
                newMonth = 12 + month % 12
            } else {
                newMonth = month
            }
        }
        
        func calculateYearGap(_ month: Int) {
            if month < 0 {
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
