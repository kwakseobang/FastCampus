//
//  VoiceRecorderView.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/25/24.
//

import SwiftUI

struct VoiceRecorderView: View {
    @StateObject private var voiceRecorderViewModel = VoiceRecorderViewModel()
    var body: some View {
        ZStack{
            VStack{
                //타이틀 뷰
                TitleView()
                //안내뷰
                if voiceRecorderViewModel.recordedFiles.isEmpty {
                    Spacer()
                    AnnouncmentView()
                    Spacer()
                }else {
                    //보이스 레코더 리스트 뷰
                    voiceRecorderListView(voiceRecorderViewModel: voiceRecorderViewModel)
                        .padding(.top,15)
                }
                Spacer()
            }
            //녹음버튼 뷰
            RecordBtnView(voiceRecorderViewModel: voiceRecorderViewModel)
                .padding(.trailing,20)
                .padding(.bottom,50)
        }
        .alert(
        "선택된 음성메모를 삭제하시겠습니까?",
        isPresented: $voiceRecorderViewModel.isDisplayRemoveVoiceRecorderAlert
        ){
            Button("삭제", role: .destructive){
                voiceRecorderViewModel.removeSelectedVoiceRecord()
            }
            Button("취소", role: .cancel) {}
        }
        .alert(
            voiceRecorderViewModel.alertMessage,
            isPresented: $voiceRecorderViewModel.isDisplayAlert
        ){
            Button("확인",role: .cancel){}
        }
    }
}

// MARK: - Title View
private struct TitleView: View {
    
    fileprivate var body: some View {
        HStack{
            Text("음성메모")
                .font(.system(size: 30,weight: .bold))
            
            Spacer()
        }
        .padding(.horizontal,30)
        .padding(.top,30)
    }
}

//MARK: - 안내 뷰
private struct AnnouncmentView: View {
    
    fileprivate var body: some View {
        VStack{
            Spacer()
            
            Image("pencil")
                .renderingMode(.template)
            Text("현재 등록된 음성메모가 없습니다.")
            Text("하단의 음성버튼을 눌러 녹음을 시작해주세요.")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.customGray0)
    }
    
}
//MARK: - 음성메모 리스트 뷰
private struct voiceRecorderListView: View {
    @ObservedObject private var voiceRecorderViewModel: VoiceRecorderViewModel
    
    fileprivate init(voiceRecorderViewModel: VoiceRecorderViewModel) {
        self.voiceRecorderViewModel = voiceRecorderViewModel
    }
    
    fileprivate var body: some View {
        ScrollView(.vertical) {
            VStack{
                Rectangle()
                    .fill(Color.customGray2)
                    .frame(height: 1)
                
                ForEach(voiceRecorderViewModel.recordedFiles,id: \.self) { recordedFile in
                    //음성메모 셀 뷰 호출
                    VoiceRecorderCellView(
                        voiceRecorderViewModel: voiceRecorderViewModel,
                        recordedFile: recordedFile
                    )
                    
                }
            }
        }
    }
}
//MARK: - 음성메모 셀 뷰
private struct VoiceRecorderCellView: View {
    @ObservedObject private var voiceRecorderViewModel: VoiceRecorderViewModel
    private var recordedFile: URL  //녹음 파일
    private var creationDate: Date?
    private var duration: TimeInterval?
    private var progressBarValue: Float {  //프로그레스바를 진행상태에 따라 값을 변경해줘야돼서
        if voiceRecorderViewModel.selectedRecoredFile == recordedFile
            && (voiceRecorderViewModel.isPlaying || voiceRecorderViewModel.isPaused ) {
            return Float(voiceRecorderViewModel.playedTime) / Float(duration ?? 1)
        }else {return 0}
        
    }
    fileprivate init(
        voiceRecorderViewModel: VoiceRecorderViewModel,
        recordedFile: URL
    ){
        self.voiceRecorderViewModel = voiceRecorderViewModel
        self.recordedFile = recordedFile
        (self.creationDate, self.duration) = voiceRecorderViewModel.getFileInfo(for: recordedFile) //file정보 가져오기
    }
    fileprivate var body: some View {
        VStack{
            Button{
                voiceRecorderViewModel.voiceRecordCellTapped(recordedFile) // 기록된 파일 클릭
            }label: {
                VStack{
                    HStack{
                        Text(recordedFile.lastPathComponent)  //새로운 녹음 n 이 표시
                            .font(.system(size: 15,weight: .bold))
                            .foregroundColor(.customBlack)
                        
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 5)
                    HStack{
                        if let creationDate = creationDate {
                            Text(creationDate.fomattedVoiceRecorderTime)
                                .font(.system(size: 13))
                                .foregroundColor(.customIconGray)
                        }
                        Spacer()
                        
                        if voiceRecorderViewModel.selectedRecoredFile != recordedFile,
                        let duration = duration {
                            Text(duration.formattedTimeInterval)
                                .font(.system(size: 14))
                                .foregroundColor(.customIconGray)
                        }
                    }
                }
            }
            .padding(.horizontal,20 )
            
            if voiceRecorderViewModel.selectedRecoredFile == recordedFile {
                VStack{
                    //프로그레스바
                    ProgressBar(progress: progressBarValue)
                        .frame(height: 2)
                    Spacer()
                        .frame(height: 5)
                    HStack{
                        Text(voiceRecorderViewModel.playedTime.formattedTimeInterval)
                            .font(.system(size: 10,weight: .medium))
                            .foregroundColor(.customIconGray)
                        
                        Spacer()
                        
                        if let duration = duration {
                            Text(duration.formattedTimeInterval)
                                .font(.system(size: 10,weight: .medium))
                                .foregroundColor(.customIconGray)
                        }
                    }
                    Spacer()
                        .frame(height: 10)
                    
                    HStack{
                         Spacer()
                        //시작 버튼
                        Button{
                            if voiceRecorderViewModel.isPaused { // 정지돼있으면 재개
                                voiceRecorderViewModel.resumePlaying()
                            }else{ // 아니면 시작
                                voiceRecorderViewModel.startPlaying(recordingURL: recordedFile)
                            }
                        }label: {
                            Image("play")
                                .renderingMode(.template)
                                .foregroundColor(.customBlack)
                        }
                        Spacer()
                            .frame(width: 10)
                        //stop
                        Button{
                            if voiceRecorderViewModel.isPlaying {
                                voiceRecorderViewModel.pausePlaying()
                            }
                        }label: {
                            Image("pause")
                                .renderingMode(.template)
                                .foregroundColor(.customBlack)
                        }
                        Spacer()
                        
                        //remove
                        Button{
                            voiceRecorderViewModel.removeBtnTapped()
                        }label: {
                            Image("trash")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 30,height: 30)
                                .foregroundColor(.customBlack)
                        }
                    }
                }
            }
        }
        .padding(.horizontal,30)
     Rectangle()
            .fill(Color.customGray2)
            .frame(height: 1)
    }
}
//MARK: - 프로그레스 바
private struct ProgressBar: View {
    private var progress: Float
    fileprivate init(progress: Float) {
        self.progress = progress
    }
    
    fileprivate var body: some View {
        //기기의 사이즈 같은 걸 읽을 수 있도록 도와주는
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(Color.customGray2)
                
                Rectangle()
                    .fill(Color.customGreen)
                    .frame(width: CGFloat(self.progress) * CGFloat(Float(geometry.size.width)))
            }
            
        }
    }
}
//MARK: - 녹응버튼 뷰
private struct RecordBtnView: View {
    @ObservedObject private var voiceRecorderViewModel: VoiceRecorderViewModel
    
    fileprivate init(voiceRecorderViewModel: VoiceRecorderViewModel) {
        self.voiceRecorderViewModel = voiceRecorderViewModel
    }
    
    fileprivate  var body: some View {
        VStack{
            Spacer()
            
            HStack{
                Spacer()
                
                Button{
                    voiceRecorderViewModel.recordBtnTapped()
                }label: {
                    if voiceRecorderViewModel.isRecording {
                        Image("mic_recording")
                            .resizable()
                            .frame(width: 80,height: 80)
                            
                    }else {
                        Image("mic")
                            .resizable()
                            .frame(width: 80,height: 80)
                    }
                }
    
            }
        }
    }
}
#Preview {
    VoiceRecorderView()
}
