//
//  HomeViewModel.swift
//  voiceMemo
//
//  Created by 곽서방 on 2/2/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var selectedTab: Tab //어느 탭바로 이동할지 알기 위해서
    @Published var todosCount: Int //설정 화면에 몇 개 가 존재하는 지 표시하기 위해
    @Published var memosCount: Int //설정 화면에 몇 개 가 존재하는 지 표시하기 위해
    @Published var voiceRecorderCount: Int //설정 화면에 몇 개 가 존재하는 지 표시하기 위해
    
    init(
        selectedTab: Tab = .voiceRecorder,
        todosCount: Int = 0,
        memosCount: Int = 0,
        voiceRecorderCount: Int = 0
    ) {
        self.selectedTab = selectedTab
        self.todosCount = todosCount
        self.memosCount = memosCount
        self.voiceRecorderCount = voiceRecorderCount
    }
}

//MARK: - 로직 부분
extension HomeViewModel {
    //3가지는 -> 각 카운트 변경
    func setTodosCount(_ count: Int) {
        todosCount = count
    }
    func setMemosCount(_ count: Int) {
        memosCount = count
    }
    func setVoiceRecordersCount(_ count: Int) {
        voiceRecorderCount = count
    }
    
    //tab 변경 메서드
    func changeSelectedTab(_ tab: Tab) {
        selectedTab = tab
    }
    
}
