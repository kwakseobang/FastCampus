//
//  Layout.swift
//  WarmUp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI

struct Layout: View {
    var body: some View {
        VStack {
            Image(systemName: "figure.run")
                .resizable()
                .scaledToFit()
                .frame(width: 150,height: 150)
            //많이 반복될경우 따로 구조체나 클래스를 만들어서 사용한다.
            MyText(inputText:"이름: kwakmunsu" , fontType:.headline )
            MyText(inputText:"성별: 남자" , fontType:.subheadline )
            MyText(inputText: "나이: 24", fontType:.body )
            
            HStack{
                MyButton(btnTitle: "Btn 1", btnColor: .blue)
                MyButton(btnTitle: "Btn 2", btnColor: .cyan)
                
            }
            Button{
            }label: {
                VStack{
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    Text("Complex Btn")
                }
                //공통인 부분
                .padding()
                .foregroundColor(.white)
                .background(.orange)
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    Layout()
}
