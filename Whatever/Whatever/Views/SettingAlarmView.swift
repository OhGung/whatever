//
//  SettingAlarmView.swift
//  Whatever
//
//  Created by 금가경 on 2023/06/14.
//

import SwiftUI

struct SettingAlarmView: View {
    @ObservedObject private var notiHelper = LocalNotificationHelper.shared
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List {
            HStack {
                Text("알림 허용")
                Toggle(isOn: $notiHelper.isNotificationOn) {
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

struct SettingAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        SettingAlarmView()
    }
}
