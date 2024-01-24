//
//  PathType.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/19/24.
//

import Foundation

enum PathType: Hashable {
    case homeView
    case todoView
    case memoView(isCreatMode: Bool, memo: Memo?)
    
}
