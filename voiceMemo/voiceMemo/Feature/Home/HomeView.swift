//
//  HomeView.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/21/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var pathModel: PathModel
    @StateObject private var homeViewModel = HomeViewModel()
    var body: some View {
        ZStack{
            //탭뷰
            TabView(selection: $homeViewModel.selectedTab){
                TodoListView()
                    .tabItem {
                        Image(
                            homeViewModel.selectedTab == .todoList
                            ? "todoIcon_selected" : "todoIcon"
                        )
                    }
                    .tag(Tab.todoList)
                
                MemoListView()
                    .tabItem {
                        Image(
                            homeViewModel.selectedTab == .memo
                            ? "memoIcon_selected" : "memoIcon"
                        )
                    }
                    .tag(Tab.memo
                    )
                VoiceRecorderView()
                    .tabItem {
                        Image(
                            homeViewModel.selectedTab == .voiceRecorder
                            ? "recordIcon_selected" : "recordIcon"
                        )
                    }
                    .tag(Tab.voiceRecorder)
                
                TimerView()
                    .tabItem {
                        Image(
                            homeViewModel.selectedTab == .timer
                            ? "timerIcon_selected" : "timerIcon"
                        )
                    }
                    .tag(Tab.timer)
                SettingView()
                    .tabItem {
                        Image(
                            homeViewModel.selectedTab == .setting
                            ? "settingIcon_selected" : "settingIcon"
                        )
                    }
                    .tag(Tab.setting)
            }
            .environmentObject(homeViewModel)
            
            //구분선
            lineView()
        }
    }
}

//MARK: - 구분선
private struct lineView: View {
    var body: some View {
        VStack{
            Spacer()
            
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]), //화이트부터 그레이까지 점점
                        startPoint: .top,
                        endPoint: .bottom
                        //top 부터 내려갈수록 그레이 로 음역
                    )
                )
                .frame(height: 30)
                .padding(.bottom,60)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(PathModel())
        .environmentObject(TodoListViewModel())
        .environmentObject(MemoListViewModel())
}
