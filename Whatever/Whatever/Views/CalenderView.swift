//
//  CalenderView.swift
//  Whatever
//
//  Created by chaekie on 2023/06/13.
//

import SwiftUI

struct CalenderView: View {
    @State var selectedMonth = 0
    @State var selectedDay = 0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(6...11, id: \.self) { month in
                    @State var month = month
                    MonthlyView(month: $month,
                             selectedDay: $selectedDay,
                             selectedMonth: $selectedMonth)
                }
            }
        }
        .clipped()
    }
    
    struct MonthlyView: View {
        @Binding var month: Int
        @Binding var selectedDay: Int
        @Binding var selectedMonth: Int
        @StateObject var customCalenderVM =  CalendarViewModel()
        @State var dayInMonth = 30
        @State var startingDay = 0
        @State var isCurrentMonth = false
        
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
                Text("\(String(customCalenderVM.currentYear))년 \(month)월")
                    .bold()
                    .foregroundColor(isCurrentMonth ? Color.black : Color.gray)
                    .frame(maxWidth: .infinity)
                    .padding(.top,20)
                
                CalenderDayView(isCurrentMonth: $isCurrentMonth)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(1...(dayInMonth+startingDay-1), id: \.self) { item in
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
                findDaysInMonth(month)
                isCurrentMonth = checkIsCurrentMonth(month)
                selectedMonth = customCalenderVM.currentMonth
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
        
        func checkIsCurrentMonth(_ month: Int) -> Bool {
            return month == customCalenderVM.currentMonth ? true : false
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
    }
}

struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalenderView()
    }
}
