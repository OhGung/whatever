//
//  AppDelegate.swift
//  Whatever
//
//  Created by 금가경 on 2023/06/14.
//
import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Foreground(앱 켜진 상태)에서도 알림 오는 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner])
    }
}
