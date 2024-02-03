//
//  TimerViewModel.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/29/24.
//

import Foundation
import UIKit

class TimerViewModel:ObservableObject {
    @Published var isDisplaySetTimeView: Bool // 타이머가 설정 안돼있을 경우랑 되어있을 경우
    @Published var time: Time
    @Published var timer: Timer?
    @Published var timeRemaining : Int
    @Published var isPaused : Bool
    var notificationService: NotificationService
    
    init(
        isDisplaySetTimeView: Bool = true,
        Time: Time = .init(hours: 0, minutes: 0, seconds: 0),
        Timer: Timer? = nil,
        timeRemaining: Int = 0,
        isPaused: Bool = false,
        notificationService: NotificationService = .init()
    ) {
        self.isDisplaySetTimeView = isDisplaySetTimeView
        self.time = Time
        self.timer = Timer
        self.timeRemaining = timeRemaining
        self.isPaused = isPaused
        self.notificationService = notificationService
    }
}
extension TimerViewModel {
    //설정하기 버튼이 탭되면
    func settingBtnTapped() {
        isDisplaySetTimeView = false
        timeRemaining = time.convertedSeconds
        //TODO: - Timer 시작 메서드 호출
        self.startTimer()
    }
    
    func cancelBtnTapped() {
        //TODO: - 타이머 종료 메서드 호출!
        self.stopTimer()
        isDisplaySetTimeView = true
    }
    func pauseOrRestartBtnTapped() {
        if isPaused {
            //TODO: - Timer 시작 메서드 호출
            self.startTimer()
            
        } else { //stop
            timer?.invalidate() // 비활성화
            timer = nil
        }
        isPaused.toggle()
    }
}
//private 으로 extensiong하면 내부도 private
private extension TimerViewModel {
    func startTimer() {
        guard timer == nil else {return} //nil이어야 설정
        
       
        var backgroundTaskID: UIBackgroundTaskIdentifier? //백그라운드 작업 아이디를 저장할 변수 초기값 nil
        //앱이 백그라운드로 전환되었을 때 일부 작업을 계속 수행할수있게 해주는 코드
        //UIBackgroundTaskIdentifier 값을 반환하며 이 값은 나중에 백그라운드 작업을 종료시키는데 사용된다.
        backgroundTaskID = UIApplication.shared.beginBackgroundTask {
            if let task = backgroundTaskID {
                //ID가 없으면 백그라운드 작업 종료
                UIApplication.shared.endBackgroundTask(task)
                backgroundTaskID = .invalid
            }
        }
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ){ _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                // TODO: - 타이머 종료 메서드 호출
                self.stopTimer()
                self.notificationService.sendNotification() //여기에서만 노티피케이션을 보낼경우 forground에서만 알림이 뜬다.
                
                if let task = backgroundTaskID {
                    UIApplication.shared.endBackgroundTask(task)
                    backgroundTaskID = .invalid
                }
            }
        }
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
