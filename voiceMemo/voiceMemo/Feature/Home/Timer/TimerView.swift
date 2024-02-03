//
//  TimerView.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/29/24.
//

import SwiftUI

struct TimerView: View {
    @StateObject var timerViewModel = TimerViewModel()
    var body: some View {
        if timerViewModel.isDisplaySetTimeView {
            // 타이머 설정 뷰
            SetTimerView(timerViewModel: timerViewModel)
            
        }else {
            //타이머 작동 뷰
            TimerOperationView(timerViewModel: timerViewModel)
        }
    }
}
// MARK: - 타이머 설정 뷰

private struct SetTimerView: View {
    @ObservedObject private var timerViewModel : TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        VStack{
            TitleView()
            
            Spacer()
                .frame(height: 100)
            
            TimePickerView(timerViewModel: timerViewModel)
            
            Spacer()
                .frame(height: 30)
            
            SetTimerBtnView(timerViewModel: timerViewModel)
            
            Spacer()
            
        }
    }
}
// MARK: - 타이틀 뷰
private struct TitleView: View {
    
    fileprivate var body: some View {
        HStack {
          Text("타이머")
            .font(.system(size: 30, weight: .bold))
            .foregroundColor(.customBlack)
          
          Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
      }
}

// MARK: - 타이머 피커 뷰
private struct TimePickerView: View {
    @ObservedObject private var timerViewModel : TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        VStack{
            Rectangle()
                .fill(Color.customGray2)
                .frame(height: 1)
            
            HStack{
                Picker("hours", selection: $timerViewModel.time.hours) {
                    ForEach(0..<24) { h in
                        Text("\(h)시")
                    }
                }
                Picker("minutes", selection: $timerViewModel.time.minutes) {
                    ForEach(0..<60) { m in
                        Text("\(m)분")
                    }
                }
                Picker("seconds", selection: $timerViewModel.time.seconds) {
                    ForEach(0..<60) { s in
                        Text("\(s)초")
                    }
                }
            }
            .labelsHidden()
            .pickerStyle(.wheel)
            
            Rectangle()
                .fill(Color.customGray2)
                .frame(height: 1)
        }
    }
}
// MARK: - Timer 생성 버튼 뷰
private struct SetTimerBtnView: View {
    @ObservedObject private var timerViewModel: TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    
    fileprivate var body: some View {
        HStack{
            Spacer()
            
            Button{
                timerViewModel.settingBtnTapped()
            }label: {
                Text("설정하기")
                    .font(.system(size: 18,weight: .bold))
                    .foregroundColor(.customGreen)
            }
            Spacer()
        }
    }
}
//MARK: - 타이머 작동 뷰
private struct TimerOperationView: View {
    @ObservedObject private var timerViewModel: TimerViewModel
    
    fileprivate init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }
    fileprivate var body: some View {
        VStack{
            ZStack{
                VStack{
                    Text("\(timerViewModel.timeRemaining.formattedTimeString)")
                        .font(.system(size: 28))
                        .foregroundColor(.customBlack)
                        .monospaced() //글자 간에 고정된 폭을 가질 때 사용한다.
                    HStack(alignment: .bottom) {
                        Image(systemName: "bell.fill")
                        
                        Text("\(timerViewModel.time.convertedSeconds.formattedSettingTime)")
                            .font(.system(size: 16))
                            .foregroundColor(.customBlack)
                            .padding(.top,10)
                    }
                }
                Circle()
                    .stroke(Color.customOrange, lineWidth: 6) //윤곽
                    .frame(width: 350)
            }
            Spacer()
                .frame(height: 10)
            
            HStack{
                Button{
                    timerViewModel.cancelBtnTapped()
                }label: {
                    Text("취소")
                        .font(.system(size: 16))
                        .foregroundColor(.customBlack)
                        .padding(.vertical,25)
                        .padding(.horizontal,22)
                        .background(
                            Circle()
                                .fill(Color.customGray2.opacity(0.3)) // opacity 투명도
                        )
                    
                }
                Spacer()
                
                Button{
                    timerViewModel.pauseOrRestartBtnTapped()
                }label: {
                    Text(timerViewModel.isPaused ? "계속 진행" : "일시 정지")
                        .font(.system(size: 16))
                        .foregroundColor(.customBlack)
                        .padding(.vertical,25)
                        .padding(.horizontal,7)
                        .background(
                            Circle()
                                .fill(Color.customOrange.opacity(0.2)) // opacity 투명도
                        )
                }
            }
            .padding(.horizontal,20)
        }
    }
}

#Preview {
    TimerView()
}
