//
//  SwiftUIView.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/19/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var pathModel = PathModel()
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @StateObject private var todoListViewModel = TodoListViewModel()
    @StateObject private var memoListViewModel = MemoListViewModel()
    
    var body: some View {
        NavigationStack(path:$pathModel.paths){
           OnboardingContentView(onboardingViewModel: onboardingViewModel)
                .navigationDestination(
                    for: PathType.self
                ) { pathType in
                    switch pathType {
                    case .homeView:
                        HomeView()
                            .navigationBarBackButtonHidden()
                            .environmentObject(todoListViewModel)
                            .environmentObject(memoListViewModel)
                    case .todoView:
                        TodoView()
                            .environmentObject(todoListViewModel)
                            .navigationBarBackButtonHidden()
                    case let  .memoView(isCreateMode,memo):
                        MemoView(
                            memoViewModel: isCreateMode
                            ? .init(memo: .init(title: "", content: "", date: .now))
                            : .init(memo: memo ?? .init(title: "", content: "", date: .now)),
                            isCreateMode:  isCreateMode
                        )
                       
//                        MemoView() // 하나는 생성모드 하나는 뷰어 에서 수정 파라미터로 넘겨준다.
                            .navigationBarBackButtonHidden()
                            .environmentObject(memoListViewModel)
                    }
                }
        }
        .environmentObject(pathModel) //전역적으로 사용
    }
}
// MARK: - 온보딩 컨텐츠 뷰
private struct OnboardingContentView: View  {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    //private면 온보딩 뷰에서 초기화할 수 없어서
    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    fileprivate var body: some View {
        VStack{
            //온보딩 셀리스트 뷰
            OnboardingCellListView(onboardingViewModel: onboardingViewModel)
            Spacer()
            //시작 버튼 뷰
            StartBtnView()
        }
        .edgesIgnoringSafeArea(.top) //safearea 무시
    }
}
// MARK: - 온보딩 셀 리스트 뷰
private struct OnboardingCellListView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    @State private var selectedIndex: Int
    
    fileprivate init(onboardingViewModel: OnboardingViewModel, selectedIndex: Int = 0) {
        self.onboardingViewModel = onboardingViewModel
        self.selectedIndex = selectedIndex
    }
    fileprivate var body: some View {
        TabView(selection: $selectedIndex){
            //온보딩 셀
            ForEach(Array(onboardingViewModel.onboardingContents.enumerated()),id: \.element){ index, onboardingContent in
                OnboardingCellView(onboardingContent: onboardingContent)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.3) //전체적으로 꽉 차게 높이는 2/3
        .background(
            selectedIndex % 2 != 0
            ? Color.ctSky
            : Color.ctBackgroundGreen
        )
        .clipped() // 탭 뷰를 구성할 때 짤리는 부분 절삭
    }
}
// MARK: - 온보딩 셀 뷰
private struct OnboardingCellView: View {
    private var onboardingContent: OnboardingContent
    fileprivate init(onboardingContent: OnboardingContent) {
        self.onboardingContent = onboardingContent
    }
    fileprivate var body: some View {
        VStack {
            Image(onboardingContent.imageFileName)
                .resizable()
                .scaledToFit()
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                        .frame(height: 46)
                    Text(onboardingContent.title)
                        .font(.system(size: 16,weight: .bold))
                    Spacer()
                        .frame(height: 5)
                    
                    Text(onboardingContent.subTitle)
                        .font(.system(size: 16))
                    
                }
                Spacer()
            }
            .background(Color.ctWhite)
            .cornerRadius(0)
        }
        .shadow(radius: 10)
    }
}

// MARK: - 시작하기 버튼 뷰
private struct StartBtnView: View {
    @EnvironmentObject var pathModel : PathModel
    fileprivate var body: some View {
        Button{
            pathModel.paths.append(.homeView)
        }label: {
            HStack{
                Text("시작하기")
                    .font(.system(size: 16,weight: .medium))
                    .foregroundColor(Color.ctGreen)
                Image("arrow")
                    .renderingMode(.template)
                    .foregroundColor(Color.ctGreen)
            }
        }
        .padding(.bottom,50)
    }
        
}
#Preview {
    OnboardingView()
}
