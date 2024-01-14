//
//  Sample.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI

struct Sample: View {
    let data = [
        Destination(direction: .north, food: "carrot",image:Image(systemName: "carrot")),
        Destination(direction: .east,food: nil, image:Image(systemName: "eraser")),
        Destination(direction: .west,food: "순대국밥", image:Image(systemName: "trash")),
        Destination(direction: .south,food: nil, image:Image(systemName: "ballon"))
    ]
   @State var selectedDest: Destination?
    var body: some View {
        VStack {
            selectedDest?.image
                .resizable() // 크기 조정
                .scaledToFit() // 비율
                .frame(width: 200,height: 200)
            if let dest = selectedDest {
                Text(dest.direction.rawValue)
                if let food = dest.food {
                    Text(food)
                }
            }
            Button {
                selectedDest = data.randomElement()
            }label: {
                Text("돌려!")
            }
        }
    }
}
struct Destination {
    let direction: Direction
    let food: String?
    let image: Image
}
enum Direction: String {
    case north = "북"
    case west = "동"
    case east = "서"
    case south = "남"
}
#Preview {
    Sample()
}
