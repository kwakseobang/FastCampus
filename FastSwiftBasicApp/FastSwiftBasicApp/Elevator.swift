//
//  Elevator.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI

struct Elevator: View {
    
    // 구조체 객체 생성
   @State var myElevator = ElevatorStruct()
    var body: some View {
        VStack{
            Text("층수: \(myElevator.layer)")
            HStack{
                Button {
                    myElevator.goDown()
                } label: {
                    Text("Down")
                }
                
                Button {
                    myElevator.goUp()
                } label: {
                    Text("Up")
                }
                
            }
        }
    }
   
}

struct ElevatorStruct {
    // 층 수 표시 display
    //up and down
    var layer = 1
    //mutating을 사용해 구조체 프로퍼티(layer) 변경한다.
   mutating func goUp() {
        self.layer += 1
    }
    mutating func goDown(){
        self.layer -= 1
    }
}

#Preview {
    Elevator()
}
