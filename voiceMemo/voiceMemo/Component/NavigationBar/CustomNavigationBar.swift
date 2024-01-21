//
//  CustomNavigationBar.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/21/24.
//

import SwiftUI

struct CustomNavigationBar: View {
    let isDisplayLeftBtn: Bool  //표현할지 말지
    let isDisplayRightBtn: Bool
    let leftBtnAction : () -> Void //어떤 액션을 담아줄건지
    let rightBtnAction : () -> Void
    let rightBtnType: NavigationBtnType //
    
    init(isDisplayLeftBtn: Bool = true,
         isDisplayRightBtn: Bool = true,
         leftBtnAction: @escaping () -> Void = {},
         rightBtnAction: @escaping () -> Void = {},
         rightBtnType: NavigationBtnType = .edit
    ) {
        self.isDisplayLeftBtn = isDisplayLeftBtn
        self.isDisplayRightBtn = isDisplayRightBtn
        self.leftBtnAction = leftBtnAction
        self.rightBtnAction = rightBtnAction
        self.rightBtnType = rightBtnType
    }
    var body: some View {
        HStack{
            if isDisplayLeftBtn {
                Button{
                    leftBtnAction()
                }label: {
                    Image("leftArrow")
                }
              
            }
            Spacer()
            if isDisplayRightBtn {
                Button{
                    rightBtnAction()
                }label: {
                    if rightBtnType == .close {
                        Image("close")
                    } else {
                        Text(rightBtnType.rawValue) //원시값
                            .foregroundColor(.ctBlack)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 20)
    }
}

#Preview {
    CustomNavigationBar()
}
