//
//  Navigation.swift
//  WarmUp
//
//  Created by 곽서방 on 1/16/24.
//

import SwiftUI

struct Navigation: View {
    let titles = ["디테일뷰로 이동하기","디테일뷰로 이동하기2","디테일뷰로 이동하기3"]
    let dest = ["destination 입니다.","destination2 입니다.","destination3 입니다."]
    @State var showModal = false
    var body: some View {
        //네비게이션을 사용하기 위해서는 stack을 깔아놓고 스택이 쌓이도록 도와주는 NavigationLink를 사용한다,
        NavigationStack {
            List{
                ForEach([0,1,2], id: \.self) { index in //[0] 부터 차례대로 
                    //어디로 가는지 쌓이도록 도와주는 연결점
                    NavigationLink {
                        Text(dest[index])
                    } label: {
                        Text(titles[index])
                    }

                }
            }
            .toolbar {
                //placement 위치 지정,
                ToolbarItem(placement: .automatic) {
                    Button {
                        showModal = true
                    } label: {
                        Text("add")
                    }
                    //모달 불러옴
                    .sheet(isPresented: $showModal) {
                        Text("Item 추가 페이지 입니다.")
                    }

                }
                
            }
        }
    }
}

#Preview {
    Navigation()
}
