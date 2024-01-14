//
//  Setting.swift
//  WarmUp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI
//모델링
struct SettingInfo: Hashable {
    let title: String
    let image: String
    let foregroundColor: Color = .white
    let backgroundColor: Color
}

struct Setting: View {
    //레이블들을 섹션으로 한번 더 감싸서 여기서도 그렇게 함
    let data : [[SettingInfo]] = [
        [ SettingInfo(title: "스크린타임", image: "hourglass", backgroundColor: .purple)],
        [SettingInfo(title: "일반", image: "gear", backgroundColor: .gray),
        SettingInfo(title: "손쉬운 사용", image: "person.crop.circle", backgroundColor: .blue),
        SettingInfo(title: "개인정보 보호 및 보안", image: "key.viewfinder", backgroundColor: .blue)],
        [SettingInfo(title: "스크린타임", image: "hourglass", backgroundColor: .gray)],
    
    
    ]
    var body: some View {
        NavigationStack {
            List {
                //섹션 별로 나누기 위해 2중 포문을 사용.
                ForEach(data, id: \.self) { section in
                    Section{ //섹션을 나누기 위해
                        ForEach(section, id: \.self) { item in
                            Label{
                                Text(item.title)
                            }icon: {
                                Image(systemName: item.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15)
                                    .padding(.all,7)
                                    .foregroundColor(item.foregroundColor)
                                    .background(item.backgroundColor)
                                    .cornerRadius(4)
                            }
                        }
                    }
                }
                .navigationTitle("설정")
            }
        }
       
    }
}

#Preview {
    Setting()
}
