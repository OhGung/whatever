//
//  PushNotificationHelper.swift
//  Whatever
//
//  Created by 금가경 on 2023/06/14.
//

import Foundation
import UserNotifications

class LocalNotificationHelper {
    static let shared = LocalNotificationHelper()
    
    private init() { }
    
    func setAuthorization(completion: ((_ success: Bool) -> Void)? = nil) {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { success, error in
                if let error = error {
                    print(#function, error)
                }
                
                if let completion = completion {
                    completion(success)
                }
            }
        )
    }
    func pushNotification(title: String, body: String, hour: Int, minute: Int, identifier: String) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in

            if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                // 알림 내용, 설정
                let notificationContent = UNMutableNotificationContent()
                notificationContent.title = title
                notificationContent.body = body
                
                // 조건(시간, 반복)
                var date = DateComponents()
                date.hour = hour
                date.minute = minute
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                
                // 요청
                let request = UNNotificationRequest(identifier: identifier,
                                                    content: notificationContent,
                                                    trigger: trigger)
                
                // 알림 등록
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Notification Error: ", error)
                    }
                }
                
                //알림 등록 되었는지 확인
                UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                    print("===== Pending =====")
                    for request in requests {
                        print(request)
                    }
                }
            }
            else {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
        }
    }
}
