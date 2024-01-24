//
//  Memo.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/23/24.
//

import Foundation

struct Memo: Hashable{
    var title: String
    var content: String
    var date: Date
    var id = UUID() //id 객체 생성
    
    var convertedDate : String {
        return String("\(date.formattedDay) - \(date.formattedTime)") //Extensions으로 정의 해놓은 것들 사용
    }
    
}
