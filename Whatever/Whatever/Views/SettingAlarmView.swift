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
