//
//  MemoListViewModel.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/23/24.
//

import Foundation

class MemoListViewModel: ObservableObject {
    @Published var memos: [Memo]
    @Published var isEditMemoMode: Bool
    @Published var removeMemos: [Memo]
    @Published var isDisplayRemoveMemoAlert: Bool
    
    var removeMemoCount: Int {
        return removeMemos.count
    }
    var navigationBarRightBtnMode: NavigationBtnType {
        isEditMemoMode ? .complete : .edit
    }
    
    init(
        memos: [Memo] = [],
        isEditMemoMode: Bool = false,
        removeMemos: [Memo] = [],
        isDisplayRemoveMemoAlert: Bool = false
    ) {
        self.memos = memos
        self.isEditMemoMode = isEditMemoMode
        self.removeMemos = removeMemos
        self.isDisplayRemoveMemoAlert = isDisplayRemoveMemoAlert
    }
    
}

extension MemoListViewModel {
    //추가
    func addMemo(_ memo: Memo) {
        memos.append(memo)
    }
    //수정
    func updateMemo(_ memo: Memo) {
        if let index = memos.firstIndex(where:{ $0.id == memo.id}) {
            memos[index] = memo
        }
    }
    //삭제
    func removeMemo(_ memo: Memo) {
        if let index = memos.firstIndex(where: {$0.id == memo.id}) {
            memos.remove(at: index)
        }
    }
    //오른쪽 버튼 클릭 시
    func navigaionRightBtnTapped() {
        if isEditMemoMode {
            if removeMemos.isEmpty {
                isEditMemoMode = false
            }else{
                setIsDisplayRemoveMemoAlert(true)
            }
        }else {
            isEditMemoMode = true
        }
    }
    func setIsDisplayRemoveMemoAlert(_ isDisplay: Bool){
        isDisplayRemoveMemoAlert = isDisplay
    }
    
    // 메모 삭제하기위한 체크버튼 눌렀을 떄
    func memoRemoveSelectedBoxTapped(_ memo: Memo) {
        if let index = removeMemos.firstIndex(of: memo) { //이미 삭제배열에 있는데 한번더 체크하면 삭제가 아닌 경우니까.
            removeMemos.remove(at: index)
        }else {
            removeMemos.append(memo)
        }
    }
    
    func removeBtnTapped() {
        memos.removeAll() { memo in
            removeMemos.contains(memo) //전체 메모 중 삭제할 메모들 삭제
        }
        removeMemos.removeAll() //초기화
        isEditMemoMode = false  // 전부 삭제했으니 편집모드 탈출
    }
}
