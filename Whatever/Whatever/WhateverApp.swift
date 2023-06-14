//
//  WhateverApp.swift
//  Whatever
//
//  Created by sei on 2023/06/10.
//

import SwiftUI

@main
struct WhateverApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        Font.registerFonts()
        
        //실제 폰트 이름 확인
        //폰트 파일명과 실제 이름이 다를 수 있음
        for family in UIFont.familyNames{
            print(family)
            for names in UIFont.fontNames(forFamilyName: family){
                print("== \(names)")
            }
        }
        LocalNotificationHelper.shared.pushNotification(title: "오늘은 생리 3일차", body: "소형 생리대 3개를 준비해 4시간마다 갈아줘!", hour: 8, minute: 00, identifier: "Whatever")
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }   
        }
    }
}
