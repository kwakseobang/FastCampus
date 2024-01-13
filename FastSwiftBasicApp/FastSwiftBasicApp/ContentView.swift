//
//  ContentView.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/13/24.
//

import SwiftUI

struct ContentView: View {
    var name: String = "Kwak"
    var body: some View {
        VStack { // 세로스택
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(name)님 안녕하세요!")
            Text("\(name)님 안녕하세요!")
            Text("\(name)님 안녕하세요!")
            Text("\(name)님 안녕하세요!")

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
