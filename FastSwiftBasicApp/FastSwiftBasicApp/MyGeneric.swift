//
//  MyGeneric.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI

struct MyGeneric: View {
    @State var input = ""
    //제네릭
    @State var myStack = MyStack<Int>()
    var body: some View {
        VStack{
            TextField("숫자를 입력해주세요",text: $input)
            Button {
                myStack.insertValue(Int(input) ?? 0)
            } label: {
                Text("저장")
            }
            Button {
                myStack.showData()
            } label: {
                Text("출력")
            }

        }
    }
}
//제네릭
struct MyStack<T> {
    var data: [T] = []
    mutating func insertValue(_ input: T) {
        data.append(input)
    }
    func showData() {
        data.forEach { item in
            print(item)
        }
    }
}
#Preview {
    MyGeneric()
}
