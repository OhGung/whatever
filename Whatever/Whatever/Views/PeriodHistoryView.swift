//
//  PeriodHistoryView.swift
//  Whatever
//
//  Created by 금가경 on 2023/06/15.
//

import SwiftUI

struct PeriodHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @State var period : [String] = ["2023년 6월 4일 ~ 6월 8일", "2023년 5월 10일 ~ 5월 14일", "2023년 4월 17일 ~ 4월 21일", "2023년 3월 22일 ~ 3월 26일"]
    @State var allPeriod : [(Int, Int)] = [(6, 4), (5, 10), (4, 17), (3, 22), (6, 8)]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ZStack {
                    RoundedCornersShape(
                        radius: 10,
                        corners: [.topLeft, .topRight]
                    )
                    .foregroundColor(.backgroundPurple)
                    .frame(width: 350, height: 135)
                    VStack {
                        Image("NinaDefault")
                            .resizable()
                            .frame(width: 61, height: 54)
                        Text("다음 생리는 6월 30일입니다")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(Color("clearWhite"))
                    }
                }
                ZStack {
                    RoundedCornersShape(
                        radius: 10,
                        corners: [.bottomLeft, .bottomRight]
                    )
                    .stroke(Color("backgroundPurple"))
                    .foregroundColor(.clear)
                    VStack(spacing: 7.0) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.lightPurple)
                                .frame(width: 39, height: 19)
                            Text("Tip")
                                .font(.custom("Inter-Regular_SemiBold", size: 12))
                                .foregroundColor(.clearWhite)
                        }
                        Text("생리 초기에는 규칙적이지 않을 수도 있어요.\n 같은 날짜에 하지 않아도 너무 걱정하지 말아요~")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }
                }
                .offset(y: -18)
                .frame(width: 350, height: 92)
                CurrentPeriodChartView()
                
                ForEach(0..<4) { i in
                    PeriodChartView(period: $period[i], allPeriod: $allPeriod[i])
                        .padding(6)
                }
            }
        }
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
}

struct PeriodHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PeriodHistoryView()
    }
}
