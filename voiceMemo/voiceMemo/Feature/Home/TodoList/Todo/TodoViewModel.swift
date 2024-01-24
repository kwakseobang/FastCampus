//
//  TodoViewModel.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/22/24.
//

import Foundation

class TodoViewModel: ObservableObject {
    @Published var title: String  //T
    @Published var time: Date
    @Published var day: Date
    @Published var isDisplayCalender: Bool
    
    init(
        title: String = "",
        time: Date = Date(),
        day: Date = Date(),
        isDisplayCalender: Bool = false
    ){
        self.title = title
        self.time = time
        self.day = day
        self.isDisplayCalender = isDisplayCalender
    }
    
}

extension TodoViewModel {
    func setIsDisplayCalender(_ isDisplay: Bool){
        isDisplayCalender = isDisplay
    }
}
