//
//  voiceMemoApp.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/19/24.
//

import SwiftUI

@main
struct voiceMemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // uikit appdelegate를 생성하는데 사용하는 프로퍼티 랩퍼
    /// 스유에서 라이프사이클을 사용하는 앱에서 앱 델리게이트 콜백을 처리할려면 UI어플리케이션델리게이트 프로토콜을 준수해야하고 각자 필요한 델리게이트 메소드를 구현해야한다.
    /// 따라서 나는 앱델리게이트 파일 생성 후 구현해줌 그 후 UIApplicationDelegateAdaptor를 사용해서 Delegate 타입을 선언해줬음
    /// SwiftUI는 델리게이트를 인스턴스화 하고 생명주기 이벤트가 발생할떄마다 응답해서 델리게이트 메서드 호출
    /// UIApplicationDelegateAdaptor 는 앱 선언부에서만 정의하고 딱 한 번만 선언해야한다. 여러 번 할 경우 런타임에러
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
