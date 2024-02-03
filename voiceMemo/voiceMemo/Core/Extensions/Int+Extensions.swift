//
//  Int+Extensions.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/29/24.
//

import Foundation

extension Int {
    var formattedTimeString: String {
        let time = Time.fromSeconds(self)
        let hourString = String(format: "%02d", time.hours)
        let minuteString = String(format: "%02d", time.minutes)
        let secondsString = String(format: "%02d", time.seconds)
        
        return "\(hourString) : \(minuteString) : \(secondsString)"
    }
    var formattedSettingTime: String {
        let currentDate = Date() // 현재 시간
        let settingDate = currentDate.addingTimeInterval(TimeInterval(self))
        
        //DateFormatter 정의
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "ASiA/Seoul")
        formatter.dateFormat = "HH:mm"
        
        let formattedString = formatter.string(from: settingDate)
        return formattedString
    }
}
