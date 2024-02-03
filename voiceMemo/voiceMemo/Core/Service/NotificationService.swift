//
//  NotificationService.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/29/24.
//

import UserNotifications

struct NotificationService {
    func sendNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) { granted, _ in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "타이머 종료!"
                content.body = "설정한 타이머가 종료되었습니다."
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false) //trigger 있으면 request도 필수
                let request = UNNotificationRequest(
                    identifier: UUID().uuidString,
                    content: content,
                    trigger: trigger
                )
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}
//델리게이트
class NotificationDelegate:NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner,.sound])
    }
}
