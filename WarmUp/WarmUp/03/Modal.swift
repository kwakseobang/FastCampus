//
//  Modal.swift
//  WarmUp
//
//  Created by 곽서방 on 1/16/24.
//

import SwiftUI

struct Modal: View {
    //상태가 바뀌어서 화면을 다시 그려야하는 걸 알려주는 변수
    @State var showModal: Bool = false
    var body: some View {
        VStack{
            Text("모달 페이지입니다.")
            Button {
                showModal = true
            } label: {
                Text("Modal 화면 전환")
            }

        }
        .sheet(isPresented: $showModal) {
            Detail(isPresented: $showModal) // 스테이트 변수를 디테일 뷰의 바인딩 변수와 엮어줌
            
        }
    }
}

#Preview {
    Modal()
}
