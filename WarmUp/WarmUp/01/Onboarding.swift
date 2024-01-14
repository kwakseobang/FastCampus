//
//  Onboarding.swift
//  WarmUp
//
//  Created by 곽서방 on 1/14/24.
//


//
import SwiftUI

struct Onboarding: View {
    var body: some View {
        VStack{
            Text("What's New in Photos")
                .font(.system(size: 35))
                .bold()
                .padding(.top,60) //위로 부터 얼마나 떨어지는 지

            
            HStack{
                Image(systemName: "person.2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
                    .foregroundColor(.blue)
                    .padding(.horizontal,7) //4만큼 양 옆
                VStack(alignment:.leading) { //text가 끝나는 시점 대한민국 기준으로 왼쪽
                    Text("Shared Library")
                        .font(.headline)
                    Text("Combine photos and videos with the peopleCombine photos and videos with the peopleCombine photos and videos")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.trailing) //text가 끝나는 시점 대한민국 기준으로 오른쪽
            }
            .padding(.vertical) //top과 buttom에 padding 넣고 싶을 떄
            
            HStack{
                Image(systemName: "trash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
                    .foregroundColor(.blue)
                    .padding(.horizontal,7) //leading과 trailng에 padding 넣고 싶을 떄
                VStack(alignment:.leading) {
                    Text("Tarsh & paper")
                        .font(.headline)
                    Text("Combine photos and videos with the peopleCombine photos and videos with the peopleCombine photos and videos")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.trailing)
            }
            .padding(.vertical)
            
            HStack{
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
                    .foregroundColor(.blue)
                    .padding(.horizontal,7) //4만큼 padding
                VStack(alignment:.leading) {
                    Text("Nice Person")
                        .font(.headline)
                    Text("Combine photos and videos with the peopleCombine photos and videos with the peopleCombine photos and videos")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.trailing)
            }
        }
        
        Spacer() // 스페이스와 같은 효과
        
        Button {
            
        }label: {
            Text("Continue")
                .padding()
                .frame(width: 350)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
        }
        .padding(.bottom,50)
    }
}

#Preview {
    Onboarding()
}
