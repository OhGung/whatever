//
//  CurrentPeriodChartView.swift
//  Whatever
//
//  Created by 금가경 on 2023/06/15.
//

import SwiftUI

struct CurrentPeriodChartView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width : 350, height : 189)
                .foregroundColor(.lighterPurple)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("mediumLightPurple"))
                )
            VStack {
                Text("현재 생리")
                HStack {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width : 52, height : 88)
                                .foregroundColor(.mediumGray)
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width : 52, height :64)
                                .foregroundColor(.vividPurple)
                                .offset(y : 11)
                        }
                        Text("1일차")
                            .font(.custom("Inter-Regular_Bold", size: 14))
                    }
                    ForEach(1..<5) { number in
                        VStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width : 52, height : 88)
                                .foregroundColor(.mediumGray)
                            Text("\(number+1)일차")
                                .font(.custom("Inter-Regular_Bold", size: 14))
                                .foregroundColor(.mediumGray)
                        }
                    }
                }
            }
        }
    }
}

struct CurrentPeriodChartView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentPeriodChartView()
    }
}
