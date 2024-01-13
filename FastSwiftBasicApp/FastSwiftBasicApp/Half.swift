//
//  Half.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/13/24.
//

import SwiftUI

struct Half: View {
//    var name = "kwakmunsu"
    var names: [String] = ["k","w","a","k","m","u","n","s","u"]
    var body: some View {
        List {
            ForEach(names, id: \.self) { item in
                var welcome = sameHi(to: item)
                if item == "m" {
                    Text("사랑해요.\(item)님")
                }
                Text(welcome)
            }
        }
    }
    func sameHi(to:String) -> String {
        return "\(to)님 만나서 반가워요^^"
    }
}

#Preview {
    Half()
}
