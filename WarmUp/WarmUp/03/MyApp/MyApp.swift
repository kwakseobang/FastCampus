//
//  MyApp.swift
//  WarmUp
//
//  Created by 곽서방 on 1/16/24.
//

import SwiftUI

struct MyApp: View {
    @State var showModal: Bool = false
    var body: some View {
        TabView{
            FirstPage()
                .tabItem {
                    Label("first", systemImage: "tray.and.arrow.down.fill")
                }
            //2
            Text("두번째페이지")
                .tabItem {
                    Label("second", systemImage: "tray.and.arrow.down.fill")
                }
            //3
            Text("세번째페이지")
                .tabItem {
                    Label("third", systemImage: "tray.and.arrow.down.fill")
                }
            Text("4번째페이지")
                .tabItem {
                    Label("third", systemImage: "tray.and.arrow.down.fill")
                }
            
        }
        .sheet(isPresented: $showModal , content: {
            //해당 뷰
            TabView{
                onbordings(title: "온보딩 1", backColor: .gray,isPresented: $showModal)
                onbordings(title: "온보딩 2", backColor: .blue,isPresented: $showModal)
                onbordings(title: "온보딩 3", backColor: .cyan,isPresented: $showModal)
                
            }
            .tabViewStyle(.page)

        })
        .onAppear() { // 뷰가 화면에 나타날 때 호출됩니다
                showModal = true
        }
    }
}

#Preview {
    MyApp()
}
