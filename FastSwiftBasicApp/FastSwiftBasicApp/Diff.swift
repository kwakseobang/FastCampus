//
//  Diff.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI

struct Diff: View {
    let myCar = Car(name: "avante", owner: "kwak")
    // 관찰하고 있다가 바뀌면 업데이트.
    @ObservedObject var myKar = Kar(name: "sonata", owner: "kwak")
    //바뀔 때 마다 업데이트댐
    @State var name: String = ""
    var body: some View {
        VStack{
            Text("\(myKar.name)의 주인은 \(myKar.owner)입니다.")
            Button {
                let broCar = myKar
                broCar.name = "moning"
                broCar.owner = "munsu"
            }label: {
                Text("출바")
            }
        }
    }
}

struct Car {
    let name: String
    let owner: String
    
    func Hello() {
        print( "Hi \(owner)")
    }
}
// ObservableObject : 관찰이 가능한 객체 (당함)
class Kar: ObservableObject {
    //변수가 바뀔 때 알림 Published
    @Published var name: String
    var owner: String
    
    init(name: String, owner: String) {
        self.name = name
        self.owner = owner
    }
    func Hello() {
        print( "Hi \(owner)님")
    }
}

#Preview {
    Diff()
}
