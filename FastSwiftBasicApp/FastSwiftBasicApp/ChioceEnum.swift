//
//  ChioceEnum.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI

struct ChioceEnum: View {
    var direction: Direction = .north
    var menu: Menu = .steak("미디움") //이렇게 값을 넣을 수도 있다,
    var body: some View {
        Text("방향은 \(direction.rawValue)쪽 입니다")
    }
}
//enum Direction: String {
//    case north = "북"
//    case west = "동"
//    case east = "서"
//    case south = "남"
//}
enum Menu {
    case pasta
    case pizza
    case steak(String)
}
#Preview {
    ChioceEnum()
}
