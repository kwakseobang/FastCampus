//
//  ContentView.swift
//  WarmUp
//
//  Created by 곽서방 on 1/14/24.
//
// 코딩없이 앱 만들기
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
            Image(systemName: "folder.fill")
                .imageScale(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                .foregroundColor(.accentColor)
            Text("Hello, world")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.purple)
                .padding(.top, 0.0)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
