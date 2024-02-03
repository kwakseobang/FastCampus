//
//  AppDelegate.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/29/24.
//

import UIKit
//swiftUI에서는 앱델리게이트가 따로 생성되지 않는다.. 따로 만들어줘야된다.
class AppDelegate: NSObject, UIApplicationDelegate{
    var notificationDelegate = NotificationDelegate()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        //런칭이 되었을 때
        UNUserNotificationCenter.current().delegate = notificationDelegate
        return true
    }
}

/// 이 상태로는 적용이 안댐 @main에 가서 적용해줘야댐
