//
//  WriteBtn.swift
//  voiceMemo
//
//  Created by 곽서방 on 2/3/24.
//

import SwiftUI

//MARK: - 1
public struct WriteBtnViewModifier: ViewModifier {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        ZStack{
            content
            
            VStack{
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Button {
                        action()
                    } label: {
                        Image("write_btn")
                    }

                }
            }
            .padding(.trailing,20)
            .padding(.bottom,50)
        }
    }
}

//MARK: - 2 뷰 확장
extension View {
    public func writeBtn(perform action: @escaping () -> Void) -> some View {
        ZStack{
            self
            
            VStack{
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Button {
                        action()
                    } label: {
                        Image("write_btn")
                    }

                }
            }
            .padding(.trailing,20)
            .padding(.bottom,50)
        }
    }
}

//MARK: - 3 새로운 뷰 생성
public struct WriteBtnView<Content: View>: View {
    let content: Content
    let action: () -> Void
    
    public init(
        @ViewBuilder content: () -> Content,
        action: @escaping () -> Void
    ) {
        self.content = content()
        self.action = action
    }
    public var body: some View {
        ZStack{
            content
        
            VStack{
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Button {
                        action()
                    } label: {
                        Image("write_btn")
                    }

                }
            }
            .padding(.trailing,20)
            .padding(.bottom,50)
        }
    }
}
