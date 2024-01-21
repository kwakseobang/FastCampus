//
//  Todo.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/21/24.
//

import Foundation

struct Todo: Hashable {
    var title: String
    var time: Date
    var day: Date
    var selected: Bool
    
    var convertedDayAndTime: String {
        //오늘 - 오후 3:00에 알림
        return String("\(day.formattedDay) - \(time.formattedTime)에 알림") //Extensions으로 정의 해놓은 것들 사용
    }
}
