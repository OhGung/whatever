//
//  SettingAlarmView.swift
//  Whatever
//
//  Created by 금가경 on 2023/06/14.
//

import SwiftUI

struct SettingAlarmView: View {
    @State private var isAlarmOn = false
    
    var body: some View {
        List {
            HStack {
                Text("알림 허용")
                Toggle(isOn: $isAlarmOn) {
                    Text("")
                }
                .onChange(of: isAlarmOn) { newState in
                    if newState {
                        LocalNotificationHelper.shared.pushNotification(title: "오늘은 생리 3일차", body: "소형 생리대 3개를 준비해 4시간마다 갈아줘!", seconds: 5, identifier: "PUSH_TEST")
                    }
                }
            }
        }
    }
}

struct SettingAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        SettingAlarmView()
    }
}
