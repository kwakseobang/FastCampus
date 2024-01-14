//
//  Selction.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI

struct Selction: View {
    var myDirection: Direction2 = .south
    var body: some View {
        switch myDirection {
            case .north:
                Text("북쪽")
            case .south:
                Text("남쪽")
            case .west:
                Text("동쪽")
            case .east:
                Text("서쪽")
        }
        
    }
}
enum Direction2: String {
    case north = "북"
    case west = "동"
    case east = "서"
    case south = "남"
}

#Preview {
    Selction()
}
