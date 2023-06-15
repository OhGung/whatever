//
//  PeriodChartView.swift
//  Whatever
//
//  Created by 금가경 on 2023/06/15.
//

import SwiftUI

struct PeriodChartView: View {
    
    @Binding var period: String
    @Binding var allPeriod : (Int, Int)
    @State private var ratio = CGFloat.random(in: 2..<6)
    var randomInts: [Int] { (0..<5).map { _ in Int.random(in: 2...5) } }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray)
                .frame(width : 350, height : 189)
            VStack {
                Text("\(period)")
                    .font(.system(size: 15))
                    .offset(y : -10)
                HStack {
                    ForEach(randomInts.indices, id:\.self) { index in
                        VStack(spacing: 5) {
                            Text("\(allPeriod.0)월 \(allPeriod.1+index)일")
                                .font(.custom("SFProDisplay-Bold", size: 11))
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width : 52, height : 88)
                                    .foregroundColor(.mediumGray)
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width : 52, height : 88 * CGFloat(randomInts[index])/5)
                                    .foregroundColor(.vividPurple)
                            }
                            Text("\(index+1)일차")
                                .font(.custom("Inter-Regular_Bold", size: 14))
                        }
                        .offset(y : 5)
                    }
                }
            }
        }
    }
}

//struct PeriodChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        PeriodChartView()
//    }
//}
