//
//  Detail.swift
//  WarmUp
//
//  Created by 곽서방 on 1/16/24.
//

import SwiftUI

struct Detail: View {
    //state 변수와 엮여있음.
    @Binding var isPresented: Bool
    var body: some View {
        Text("모달 페이지 입니디.")
        Button {
            isPresented = false //false로 바뀌면 이 바인딩 변수와 엮어있는 modal 뷰에 스테이드 변수도 false로 바뀜
        } label: {
            Text("닫기")
        }

    }
}

#Preview {
    Detail(isPresented: .constant(true)) //constant 언제나 true로 한다
}
