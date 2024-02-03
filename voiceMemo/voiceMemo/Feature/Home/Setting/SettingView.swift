//
//  SettingView.swift
//  voiceMemo
//
//  Created by 곽서방 on 2/2/24.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    var body: some View {
        VStack{
            //타이틀 뷰
            TitleView()
                
            Spacer()
                .frame(height: 35)
            // 총 탭 카운트 뷰
            TotalTabCountView()
            
            Spacer()
                .frame(height: 40)
            //총 탭 무브 뷰
            
            TotalTabMoveView()
            
            Spacer()
        }
    }
}
// MARK: - Title View
private struct TitleView: View {
    fileprivate var body: some View {
        HStack{
            Text("설정")
                .font(.system(size: 30,weight: .bold))
                .foregroundColor(.customBlack)
                
            Spacer()
        }
        .padding(.horizontal,30)
        .padding(.top,40)
    }
}
// MARK: -  전체 탭 설정된 카운트 뷰
private struct TotalTabCountView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel

    fileprivate var body: some View {
        //각각 탭 카운트 뷰(todo,memo,voice)
        HStack{
            TabCountView(title: "To do", count: homeViewModel.todosCount)
            
            Spacer()
                .frame(width: 70)
            TabCountView(title: "메모", count: homeViewModel.memosCount)
            
            Spacer()
                .frame(width: 70)

            TabCountView(title: "음성 메모", count: homeViewModel.voiceRecorderCount)
        }
    }
}
//MARK: - 각 탭 설정된 카운트 뷰 ( 공통 뷰 컴포넌트)
private struct TabCountView: View {
    private var title: String
    private var count: Int
    
    fileprivate init(
        title: String,
        count: Int
    ) {
        self.title = title
        self.count = count
    }
    
    fileprivate var body: some View {
        VStack(spacing:5){
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.customBlack)
            
            Text("\(count)")
                .font(.system(size: 30,weight: .medium  ))
                .foregroundColor(.customBlack)
        }
    }
}
// MARK: - 전체 탭 이동 뷰
private struct TotalTabMoveView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel

    fileprivate var body: some View {
        VStack{
            Rectangle()
                .fill(Color.customGray2)
                .frame(height: 1)
            
        // 긱 텝 4개 이동 뷰 컴포넌트
            TabMoveView(
                title: "To do List"
            ) {
                homeViewModel.changeSelectedTab(.todoList)
                }
            
            TabMoveView(
                title: "메모"
            ) {
                homeViewModel.changeSelectedTab(.memo)
                }
            
            TabMoveView(
                title: "음성 메모"
            ) {
                homeViewModel.changeSelectedTab(.voiceRecorder)
                }
            
            TabMoveView(
                title: "타이머"
            ) {
                homeViewModel.changeSelectedTab(.timer)
                }
            
            Rectangle()
                .fill(Color.customGray2)
                .frame(height: 1)
        }
    }
}

//MARK: - 각 탭 이동 뷰
private struct TabMoveView: View {
    private var title: String
    private var tabAction: () -> Void
    
    fileprivate init(
        title: String,
        tabAction: @escaping () -> Void
    ) {
        self.title = title
        self.tabAction = tabAction
    }
    
    fileprivate var body: some View {
        Button{
            tabAction()
        }label: {
            HStack{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(.customBlack)
                
                Spacer()
                
                Image("arrowRight")
                    .foregroundColor(.customGray0)
                
            }
        }
        .padding(.all,15)
        
      
    }
}
#Preview {
    SettingView()
        .environmentObject(HomeViewModel())
}
