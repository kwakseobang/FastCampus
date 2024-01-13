//
//  Condition.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/13/24.
//

import SwiftUI

struct Condition: View {
    var hasLoggedIn = false
    var count = 4
    var body: some View {
        if hasLoggedIn {
            Text("로그아웃 하실거?")
        } else {
            Text("로그인 하실거?")
        }
       
    }
}

#Preview {
    Condition()
}
