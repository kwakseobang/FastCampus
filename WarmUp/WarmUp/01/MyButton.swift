//
//  MyButton.swift
//  WarmUp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI

struct MyButton: View {
    var btnTitle: String
    var btnColor: Color
    var body: some View {
        Button{
        }label: {
            Text("\(self.btnTitle)")
                .padding()
                .bold()
                .background(self.btnColor)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

#Preview {
    MyButton(btnTitle: "Btn 1", btnColor: .black)
}
