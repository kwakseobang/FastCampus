//
//  Loop.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/13/24.
//

import SwiftUI

struct Loop: View {
    let names: [String] = ["k","w","a","k","m","u","n","s","u"]
    var body: some View {
        VStack {
            //names에 있는 요소들이 하나씩 item으로 할당
            ForEach(names, id: \.self) { item in
                Text(item)
            }
        }
    }
}

#Preview {
    Loop()
}
