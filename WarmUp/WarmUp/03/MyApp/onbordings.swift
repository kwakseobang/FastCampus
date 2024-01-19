//
//  onbordings.swift
//  WarmUp
//
//  Created by 곽서방 on 1/16/24.
//

import SwiftUI

struct onbordings: View {
    var title = ""
    var backColor: Color
    @Binding var isPresented: Bool
    var body: some View {
        ZStack{
            self.backColor.ignoresSafeArea()
            VStack{
                Text(self.title)
                    .padding()
                    .bold()
                    if self.title == "온보딩 3"{
                        Button {
                            isPresented = false
                        } label: {
                            Text("Home")
                        }

                    
                    }
            }
        }
    }
}

#Preview {
    onbordings(title: "온보딩테스트", backColor: .cyan,isPresented: .constant(true))
}
