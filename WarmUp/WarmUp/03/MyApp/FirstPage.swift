//
//  FirstPage.swift
//  WarmUp
//
//  Created by 곽서방 on 1/16/24.
//

import SwiftUI

struct FirstPage: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink {
                    Text("첫번째 하위페이지")
                }label: {
                    Text("1번째 하위페이지")
                }
                NavigationLink {
                    Text("두번째 하위페이지")
                }label: {
                    Text("2번째 하위페이지")
                }
                NavigationLink {
                    Text("세번째 하위페이지")
                }label: {
                    Text("3번째 하위페이지")
                }
                NavigationLink {
                    Text("네번째 하위페이지")
                }label: {
                    Text("4번째 하위페이지")
                }
                .navigationTitle("리스트")
            }
        }
    }
}

#Preview {
    FirstPage()
}
