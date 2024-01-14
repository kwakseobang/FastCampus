//
//  MyText.swift
//  WarmUp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI

struct MyText: View {
    var inputText: String
    var fontType: Font
    var body: some View {
        Text("\(inputText)")
            .font(self.fontType)
            .bold()
            .padding()
    }
}

#Preview {
    MyText(inputText: "", fontType: .body)
}
