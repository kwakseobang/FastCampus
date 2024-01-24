//
//  TodoListView.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/21/24.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel //todoview를 불러와야돼
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    var body: some View {
        ZStack{
            //todo cell list
            VStack{
                if !todoListViewModel.todos.isEmpty {
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        rightBtnAction: {
                            todoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: todoListViewModel.navigationBarRigthBtnMode
                    )
                    
                }else { // todoList가 비어있을 경우
                    Spacer()
                        .frame(height: 30)
                }
                TitleView()
                    .padding(.top,40)
                if todoListViewModel.todos.isEmpty{
                    AnnouncmentView()
                        
                }else{
                    TodoListContentView()
                        .padding(.top,20)
                }
            }
            WriteTodoBtnView()
                .padding(.trailing,30)
                .padding(.bottom,50)
        }
        .alert(
             "To do list \(todoListViewModel.removeTodosCount)개 삭제하시겠습니까?",
             isPresented: $todoListViewModel.isDisplayRemoveTodoAlert  //true일 시 작동
           ) {
             Button("삭제", role: .destructive) {
               todoListViewModel.removeBtnTapped() // 삭제
             }
             Button("취소", role: .cancel) { }
           }
    
    }
}
//MARK: - TodoList 타이틀 뷰
private struct TitleView: View {
    @EnvironmentObject private var todoListViewModel:TodoListViewModel
    fileprivate var body: some View {
        HStack{
            if todoListViewModel.todos.isEmpty {
                Text("To do list를\n추가해 보세요.")
            }else {
                Text("To do list \(todoListViewModel.todos.count)개가\n있습니다.")
            }
            Spacer()
            
        }
        .font(.system(size: 30,weight: .bold))
        .padding(.leading,20)
    }
}
//MARK: - TodoList 안내 뷰
private struct AnnouncmentView: View {
    fileprivate var body: some View {
        VStack(spacing:15){
            Spacer()
                .frame(height: 100)
            Image("pencil")
                .renderingMode(.template)
            Text("매일 아침 8시 운동하자!")
            Text("내일 8시 수강 신청하자!")
            Text("1시 반 점심약속 리마인드 해보자!")
            Spacer()
        }
        .font(.system(size: 18))
        .foregroundColor(.customGray2)
    }
}
//MARK: - TodoList 컨텐츠 뷰
private struct TodoListContentView: View {
    @EnvironmentObject private var todoListViewModel:TodoListViewModel
    fileprivate var body: some View {
        VStack{
            HStack{
                Text("할일 목록")
                    .font(.system(size: 16,weight: .bold))
                    .padding(.leading,20)
                Spacer()
            }
            //수직
            ScrollView(.vertical){
                VStack(spacing: 15){
                    Rectangle()
                        .fill(Color.customGray0) //구분선 색
                        .frame(height: 1)
                    ForEach(todoListViewModel.todos,id: \.self){ todo in
                        //TODO: - Todo 셀 뷰 todo 넣어서 뷰 호출하기
                        TodoListCelltView(todo: todo)
                
                    }
                    
                }
            }
        }
    }
    
//MARK: - Todo cell 뷰
    private struct TodoListCelltView: View {
        @EnvironmentObject private var todoListViewModel:TodoListViewModel
        @State private var isRemoveSelected: Bool
        private var todo: Todo
        fileprivate init(
            isRemoveSelected: Bool = false,
            todo: Todo
        ) {
            _isRemoveSelected = State(initialValue: isRemoveSelected)
            self.todo = todo
        }
        fileprivate var body: some View {
            VStack(spacing: 20){
                HStack{
                    if !todoListViewModel.isEditTodoMode {
                        Button{
                            todoListViewModel.selectedBoxTapped(todo) // 선택되었을 시 todo 담는다.
                        }label: {
                            todo.selected ? Image("selectedBox") : Image("unSelectedBox") // true 시  Image("selectedBox")
                        }
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text(todo.title)
                            .font(.system(size: 16))
                            .foregroundColor(todo.selected ? .customIconGray : .customBlack)
                            .strikethrough(todo.selected) // true일시 밑줄
                        
                        Text(todo.convertedDayAndTime)
                            .font(.system(size: 16))
                            .foregroundColor(.customIconGray)
                    }
                    Spacer()
                    
                    if todoListViewModel.isEditTodoMode {
                        Button {
                            isRemoveSelected.toggle()
                            todoListViewModel.todoRemoveSelectedBoxTapped(todo)
                        }label: {
                            isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox") // true 시  Image("selectedBox")
                        }
                    }
                }
            }
            .padding(.horizontal,20)
            .padding(.top,10)
            
            Rectangle()
                .fill(Color.customGray0) //구분선 색
                .frame(height: 1)
        }
    }
}
//MARK: - Todo 작성 버튼 뷰
private struct WriteTodoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    fileprivate var body: some View {
        VStack{
            Spacer()
            
            HStack{
                Spacer()
                
                Button{
                    pathModel.paths.append(.todoView)
                }label: {
                    Image("write_btn")
                }
            }
        }
    }
}
#Preview {
    TodoListView()
        .environmentObject(PathModel())
        .environmentObject(TodoListViewModel())
}
