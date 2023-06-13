//
//  CalenderDayView.swift
//  Whatever
//
//  Created by chaekie on 2023/06/13.
//

import SwiftUI

struct CalenderDayView: View {
    @Binding var isCurrentMonth: Bool
    let day = ["일", "월", "화", "수", "목", "금", "토"]
    
    func changeDayColor(_ day: String) -> Color {
        guard isCurrentMonth else { return Color.gray }
        if day == "토" {
            return Color.blue
        } else if day == "일" {
            return Color.red
        } else {
            return Color.black
        }
    }
    
    func getDayText(_ day: String) -> some View {
        return Text(day)
            .bold()
            .frame(maxWidth: .infinity)
            .foregroundColor(changeDayColor(day))
    }
    
    var body: some View {
        HStack {
            ForEach(day, id: \.self){ day in
                getDayText(day)
            }
        }
        .padding()
    }
}


struct CalenderDayView_Previews: PreviewProvider {
    static var previews: some View {
        CalenderDayView(isCurrentMonth: .constant(true))
    }
}
