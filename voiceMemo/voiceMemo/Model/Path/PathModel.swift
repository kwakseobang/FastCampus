//
//  PathModel.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/19/24.
//

import Foundation
class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
