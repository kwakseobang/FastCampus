//
//  MemoViewModel.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/23/24.
//

import Foundation

class MemoViewModel: ObservableObject {
    @Published var memo: Memo
    
    init(
        memo: Memo
    ) {
        self.memo = memo
    }
    
}
