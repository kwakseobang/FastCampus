//
//  TodoVIew.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/22/24.
//

import SwiftUI

struct TodoView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @StateObject private var todoViewModel = TodoViewModel()
    var body: some View {
        VStack{
            CustomNavigationBar(
                leftBtnAction: {
                    pathModel.paths.removeLast()  //back Btn을 누르게 되면 최상단의 todo view가 닫힌다.
                },
                rightBtnAction: {
                    //생성
                    todoListViewModel.addTodo(
                        .init(
                            title: todoViewModel.title,
                            time: todoViewModel.time,
                            day: todoViewModel.day,
                            selected: false
                            )
                        )
                    pathModel.paths.removeLast()
                    },
                rightBtnType: .create
            )
            //title view
            TitleView()
                .padding(.top,20)
            Spacer()
                .frame(height: 20)
            //todo title view(textfeild)
             TodoTitleView(todoViewModel: todoViewModel)
                .padding(.leading,20)
            //time selected
            SelectTimeView(todoViewModel: todoViewModel)
            //day selected
            SelectDayView(todoViewModel: todoViewModel)
                .padding(.leading,20)
            Spacer()
        }
    }
}
// MARK: - Title View
private struct TitleView: View {
    fileprivate var body: some View {
        HStack{
            Text("To do list를\n추가해 보세요.")
            Spacer()
        }
        .font(.system(size: 30,weight: .bold))
        .padding(.leading,20)
    }
}
//MARK: - Todo Title View
private struct TodoTitleView: View {
    @ObservedObject private var todoViewModel : TodoViewModel
    fileprivate init(todoViewModel: TodoViewModel){
        self.todoViewModel = todoViewModel
    }
    fileprivate var body: some View {
        TextField("제목을 입력하세요.",text: $todoViewModel.title) //바인딩
    }
}
//MARK: - 시간 선택
private struct SelectTimeView: View {
    @ObservedObject private var todoViewModel : TodoViewModel
    fileprivate init(todoViewModel: TodoViewModel){
        self.todoViewModel = todoViewModel
    }
    fileprivate var body: some View {
        VStack{
            Rectangle() //구분선
                .fill(Color.customGray0)
                .frame(height: 1)
            
            DatePicker(
                "",  //제목
                selection: $todoViewModel.time,  //바인딩
                displayedComponents: [.hourAndMinute] // 시간과 분
            )
            .labelsHidden()
            .datePickerStyle(WheelDatePickerStyle()) //휠 스타일
            .frame(maxWidth: .infinity, alignment: .center)
            
            Rectangle() //구분선
                .fill(Color.customGray0)
                .frame(height: 1)
        }
    }
}

//MARK: - 날짜 선택
private struct SelectDayView: View {
    @ObservedObject private var todoViewModel : TodoViewModel
    fileprivate init(todoViewModel: TodoViewModel){
        self.todoViewModel = todoViewModel
    }
    fileprivate var body: some View {
        VStack(spacing: 5){
            HStack{
                Text("날짜")
                    .foregroundColor(.customIconGray)
                Spacer()
            }
            
            HStack{
                Button{
                    todoViewModel.setIsDisplayCalender(true)
                }label: {
                    Text("\(todoViewModel.day.formattedDay)")
                        .font(.system(size: 18,weight: .medium))
                        .foregroundColor(.customGreen)
                }
                .popover(isPresented: $todoViewModel.isDisplayCalender) {
                    DatePicker(
                        "",
                        selection: $todoViewModel.day,
                        displayedComponents: .date
                        
                        )
                    .labelsHidden()
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    //todoViewModel.day 값이 변경될떄마다 어떤 로직을 수행할 지 결정
                    .onChange(of: todoViewModel.day) {  a,v in
                        todoViewModel.isDisplayCalender = false // 날짜 선택 시 닫힘
                    }
                }
                Spacer()
            }
        }
    }
        
}
#Preview {
    TodoView()
}
