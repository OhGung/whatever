//
//  NotificationAllowOneView.swift
//  Whatever
//
//  Created by 금가경 on 2023/06/13.
//

import SwiftUI

import SwiftUI

struct NotificationAllowOneView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.lightPurple)
                    .frame(height: 54)
                Text("왓에버(Whatever) 이용을 위해\n 다음 화면에서 '허용'을 눌러주세요.")
                    .foregroundColor(.clearWhite)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16))
            }
            Spacer()
            Image("NinaWithTeeth")
                .padding(.bottom, 33.0)
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .circular)
                    .stroke(.gray)
                    .frame(width: 350, height: 81)
                    .foregroundColor(.clear)
                Text("생리 기간 중 아침에 한 번\n **하루동안 사용할 생리대 개수**를 \n알려줄게.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16))
            }
            .padding(.bottom, 33.0)
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .circular)
                    .stroke(.gray)
                    .frame(width: 350, height: 81)
                    .foregroundColor(.clear)
                Text("다음 버튼을 누르면 나오는\n 알림창의 ‘**허용**’을 눌러서\n 우리가 도와줄 수 있게 해줘.")
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
            }
            .hidden()
            Spacer()
            Button(action: {
            }) {
                NavigationLink(destination: NotificationAllowTwoView()) {
                    Image("NextButtonActive")
                }
            }
        }
    }
}

struct NotificationAllowOneView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationAllowOneView()
    }
}
