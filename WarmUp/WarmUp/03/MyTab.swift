//
//  MyTeb.swift
//  WarmUp
//
//  Created by 곽서방 on 1/16/24.
//

import SwiftUI

struct MyTab: View {
    var body: some View {
        TabView {//탭 뷰안에 뷰 넣으면 들어감
            TabDetail()
                .badge(2) // 숫자, 문자열 다 들어가!
                .tabItem { //item을 넣지 않으면 빈칸 하지만 자리는 잡힘 그 자리 클릭 시 이동
                    Label("Received", systemImage: "tray.and.arrow.down.fill")
                }
            TabDetail2()
                .tabItem {
                    Label("Sent", systemImage: "tray.and.arrow.up.fill")
                }
            TabDetail3()
                .badge("!")
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
        }
        .tabViewStyle(.page(indexDisplayMode: .always)) //탭뷰 스타일
    }
}

#Preview {
    MyTab()
}
