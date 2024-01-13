//
//  Function.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/13/24.
//

import SwiftUI

struct Function: View {
    //나중에 설명
  @State  var inputNum = 10
    var body: some View {
        VStack{
            Text("Input number is \(inputNum)")
            
            Button {
                //action part
                inputNum = Plus(inputNum)
            } label: {
                //label part
                Text("+10")
            }

        }
    }
    
    func Plus(_ input: Int) -> Int {
        return input + 10
    }
}

#Preview {
    Function()
}
