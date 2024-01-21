//
//  TodoListViewModel.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/21/24.
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo] //Model로 만든 Todo 가져오기
    @Published var isEditTodoMode: Bool // 편집모드인지 생성모드인지
    @Published var removeTodos: [Todo] // 어떤 것들이 삭제될 예정인지
    @Published var isDisplayRemoveTodoAlert: Bool // 삭제 시 메시지 호출할건지
    
    var removeTodosCount: Int {  //삭제할 Todo 개수
        return removeTodos.count
    }
    var navigationBarRigthBtnMode: NavigationBtnType {  //편집모드에 들어갔을 떈 완료버튼 띄우고 편집 아닐 시는 편집 띄우기
        isEditTodoMode ? .complete : .edit
    }
    init(todos: [Todo] = [],
         isEditTodoMode: Bool = false,
         removeTodos: [Todo] = [],
         isDisplayRemoveTodoAlert: Bool = false
    ) {
        self.todos = todos
        self.isEditTodoMode = isEditTodoMode
        self.removeTodos = removeTodos
        self.isDisplayRemoveTodoAlert = isDisplayRemoveTodoAlert
    }
}
//실제 로직
extension TodoListViewModel {
    //투두리스트가 체크 되었는지
    func selectedBoxTapped(_ todo: Todo){
        // 배열 todos에서 todo 변수와 동일한 값을 가진 첫 번째 요소의 인덱스를 찾아서 index에 저장하는 것입니다
        if let index = todos.firstIndex(where: { $0 == todo } ) { //firstIndex주어진 조건을 만족하는 첫 번째 요소의 인덱스를 반환합니다.
            todos[index].selected.toggle() //check 했으면 토글
            
        }
    }
    //생성 누를 시 todo배열에 할 일 추가
    func addTodo(_ todo: Todo){
        todos.append(todo)
    }
    //네비게이션 바 우측 버튼 역할
    func navigationRightBtnTapped() {
        if isEditTodoMode {
            if removeTodos.isEmpty { //삭제할게 비어있다면
                isEditTodoMode = false
            } else {
                //얼럿을 불러준다
                setIsDisplayRemoveTodoAlert(true)
            }
        }else {
            isEditTodoMode = true
        }
    }
    func setIsDisplayRemoveTodoAlert(_ isDisplay: Bool){
        isDisplayRemoveTodoAlert = isDisplay
    }
    //                              삭제해줘야하는 투두 정보
    func todoRemoveSelectedBoxTapped(_ todo: Todo) {
        //todo가 들어있냐
        if let index = removeTodos.firstIndex(of: todo) {
            removeTodos.remove(at: index)
        }else {
            removeTodos.append(todo)
        }
    }
    
    func removeBtnTapped() {
        todos.removeAll() { todo in
            removeTodos.contains(todo) //전체 todo 리스트 중 포함되어있는 거 삭제
        }
        removeTodos.removeAll() // 초기화
        isEditTodoMode = false
    }
}
