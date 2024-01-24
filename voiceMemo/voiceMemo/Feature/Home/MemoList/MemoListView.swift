//
//  MemoListView.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/23/24.
//

import SwiftUI

struct MemoListView: View {
    @EnvironmentObject private var pathModel : PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel // memoView에서도 뷰 모델의 상태를 공유하고 전역적으로 사용
    var body: some View {
        ZStack {
            VStack{
                if !memoListViewModel.memos.isEmpty{
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        rightBtnAction: {
                            memoListViewModel.navigaionRightBtnTapped()
                        },
                        rightBtnType: memoListViewModel.navigationBarRightBtnMode
                    )
                }else {
                    Spacer()
                        .frame(height: 30)
                }
                //title view
                TitleView()
                    .padding(.top,30)
                if memoListViewModel.memos.isEmpty {
                    //안내 뷰
                    AnnouncmentView()
                }else {
                    MemoListContentView()
                        .padding(.top,20)
                }
            }
            //메모작성 플로팅 아이콘 버튼 뷰
            WriteMemoBtnView()
                .padding(.trailing, 30)
                .padding(.bottom,50)
        }
        .alert(
            "메모 \(memoListViewModel.removeMemoCount)개 삭제하시겠습니까?",
            isPresented: $memoListViewModel.isDisplayRemoveMemoAlert  //true일 시 작동
          ) {
            Button("삭제", role: .destructive) {
              memoListViewModel.removeBtnTapped() // 삭제
            }
            Button("취소", role: .cancel) { }
          }
    }
}

//MARK: - Title View
private struct TitleView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    
    fileprivate var body: some View {
        HStack{
            if memoListViewModel.memos.isEmpty {
                Text("메모를\n추가해보세요")
            }else {
                Text("메모\(memoListViewModel.memos.count)개가\n있습니다.")
            }
            Spacer() //
        }
        .font(.system(size: 30,weight: .bold))
        .padding(.leading,20)
    }
    
}

//MARK: - 안내 뷰
private struct AnnouncmentView: View {
    
    fileprivate var body: some View {
        VStack(spacing:10){
            Spacer()
                .frame(height: 200)
            
            Image("pencil")
                .renderingMode(.template)
            Text("내일 오후 4시 교정국 회의 메모")
            Text("내일 오후 6시 공식 회의 메모")
            Text("내일 오후 12 출근하기 메모")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.customGray2)
    }
}

// MARK: - 메모 리스트 컨텐츠 뷰
private struct MemoListContentView: View {
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    fileprivate var body: some View {
        VStack{
            
            HStack{
                Text("메모 목록")
                    .font(.system(size:16,weight: .bold))
                    .padding(.leading,20)
                Spacer()
            }
            //수직
            ScrollView(.vertical){
                VStack(spacing:15){
                    Rectangle()
                        .fill(Color.customGray0)
                        .frame(height: 1)
                    ForEach(memoListViewModel.memos,id: \.self) { memo in
                        //memo 셀 뷰
                        MemoCellView(memo: memo)
                    }
                }
            }
        }
    }
}


//MARK: - 메모 셀 뷰
private struct MemoCellView: View {
    //viewer 타입에서 클릭하면 그 해당 메모뷰로 가야되기때문에 pathModel 필요
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListViewModel: MemoListViewModel
    //삭제 체크박스 체크를 위해 Bool Type
    @State private var isRemoveSelected: Bool
    private var memo:Memo
    
    fileprivate init(
        isRemoveSelected: Bool = false,
        memo: Memo
    ){
        _isRemoveSelected = State(initialValue: isRemoveSelected)
        self.memo = memo
    }
    
    fileprivate var body: some View {
        Button{
            // TODO: - path 관련 메모 구현 후 구현 필요
            pathModel.paths.append(.memoView(isCreatMode: false, memo: memo))
        }label: {
            VStack(spacing: 10) {
                HStack{
                    VStack(alignment: .leading){
                        Text(memo.title)
                            .lineLimit(1)
                            .font(.system(size: 16))
                            .foregroundColor(.customBlack)
                        Text(memo.convertedDate)
                            .font(.system(size: 12))
                            .foregroundColor(.customIconGray)
                    }
                    Spacer()
                    
                    if memoListViewModel.isEditMemoMode {
                        Button {
                            isRemoveSelected.toggle()
                            memoListViewModel.memoRemoveSelectedBoxTapped(memo) //click 시 삭제할 메모 배열에 해당 메모가 담긴다.
                        }label: {
                            isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox") // true 시  Image("selectedBox")
                        }
                    }
                }
            }
            .padding(.horizontal,30)
            .padding(.top,10)
            
        }
        Rectangle()
            .fill(.customGray0)
            .frame(height: 1)
    }
}

//MARK: - Memo 작성 버튼 뷰
private struct WriteMemoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        VStack{
            Spacer()
            
            HStack{
                
                Spacer()
                
                Button{
                    pathModel.paths.append(.memoView(isCreatMode: true, memo: nil))  //action
                }label: {
                    Image("write_btn")
                }
            }
        }
    }
}

#Preview {
    MemoListView()
        .environmentObject(PathModel())
        .environmentObject(MemoListViewModel())
}
