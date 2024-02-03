//
//  Timer.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/29/24.
//

import Foundation

struct Time {
    //시, 분, 초, 변환된ㄷ 시간
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    var convertedSeconds: Int {
        return (hours * 3600) + (minutes * 60) + seconds
        
    }
    static func fromSeconds(_ seconds: Int) -> Time {
        let h = seconds / 3600
        let m = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        return Time(hours: h, minutes: m, seconds: remainingSeconds)
    }
}
