//
//  SimpleVIew.swift
//  WarmUp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI

struct SimpleVIew: View {
    var body: some View {
        VStack{
            Image(systemName: "folder.fill")
                .resizable() //size 변경 가능
                .scaledToFit() //비율에 맞게
                .frame(width: 200,height: 200)
            Text("헤드라인 입니다.")
                .font(.headline)
                .bold()
                .padding()  //암것도 안쓰면 네 방향 다 패딩
            Text("서브헤드라인 입니다.")
                .font(.subheadline)
                .padding()
            Text("바디 입니다.")
                .font(.body)
                .padding()
            Button {
                
            }label: {
                //코드 순서에 따라서 다르다.
                Text("Click Me")
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .bold()
            }
        }
    }
}

#Preview {
    SimpleVIew()
}
