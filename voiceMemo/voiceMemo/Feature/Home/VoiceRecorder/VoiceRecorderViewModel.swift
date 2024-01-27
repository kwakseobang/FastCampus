//
//  VoiceRecoderViewModel.swift
//  voiceMemo
//
//  Created by 곽서방 on 1/25/24.
//

import AVFoundation
class VoiceRecorderViewModel : NSObject, ObservableObject, AVAudioPlayerDelegate{
    @Published var isDisplayRemoveVoiceRecorderAlert: Bool
    @Published var isDisplayAlert: Bool //파일 가져오기 실패, 녹음 x 등 그런 상황일 때 얼럿 띄어주기 위해서
    @Published var alertMessage: String // 얼럿 띄울 때 어떤 메세지를 담을 것인지.
    
    ///음성 메모 녹음 관련 프로퍼티
    var audioRecorder: AVAudioRecorder?
    @Published var isRecording: Bool
    
    
    
    ///음성 메모 재생 관련 프로퍼티
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying: Bool
    @Published var isPaused: Bool
    @Published var playedTime: TimeInterval //얼마나 재생되엇는지
    private var progressTimer: Timer?  //time 바
    
    
    ///음성 메모된 파일
    var recordedFiles: [URL]
    
    /// 현재 선택된 음성메모 파일
    @Published var selectedRecoredFile: URL?
    
    init(isDisplayRemoveVoiceRecorderAlert: Bool = false,
         isDisplayErrorAlert: Bool = false,
         errorAlertMessage: String = "",
         isRecording: Bool = false,
         isPlaying: Bool = false,
         isPaused: Bool = false,
         playedTime: TimeInterval = 0,
         recordedFiles: [URL] = [],
         selectedRecoredFile: URL? = nil
    ) {
        self.isDisplayRemoveVoiceRecorderAlert = isDisplayRemoveVoiceRecorderAlert
        self.isDisplayAlert = isDisplayErrorAlert
        self.alertMessage = errorAlertMessage
        self.isRecording = isRecording
        self.isPlaying = isPlaying
        self.isPaused = isPaused
        self.playedTime = playedTime
        self.recordedFiles = recordedFiles
        self.selectedRecoredFile = selectedRecoredFile
    }
    
}
//뷰에서 일어날 수 있는 로직들
extension VoiceRecorderViewModel {
    // 녹음된 셀을 탭했을 시
    func voiceRecordCellTapped(_ recordedFile: URL) {
        
        if selectedRecoredFile != recordedFile {
            // TODO: - 재생정지 메서드 호출
            stopPlaying()
            selectedRecoredFile = recordedFile //선택된 파일 현재 파일로 변경
        }
    }
    func removeBtnTapped() {
        //TODO: - 삭제 얼럿 노출을 위한 상태 변경 메서드 호출
        setIsDisplayRemoveVoiceRecorderAlert(true)
    }
    
    func removeSelectedVoiceRecord() {
        guard let fileToRemove = selectedRecoredFile,
              let indexToRemove = recordedFiles.firstIndex(of: fileToRemove) else {
            // TODO: - 선택된 음성메모를 찾을 수 없다는 에러 얼럿 노출
            disPlayAlert(message: "선택된 음성메모 파일을 찾을 수 없습니다.")
            return
        }
        do {
            try FileManager.default.removeItem(at: fileToRemove) // 메서드는 파일 시스템에서 지정된 경로에 있는 파일을 삭제, 경로는 at: 매개변수에 전달
            recordedFiles.remove(at: indexToRemove) // 녹음 파일 배열들에서도 삭제
            selectedRecoredFile = nil
            //TODO: - 재생 정지 메서드 호출
            stopPlaying()
            //TODO: - 삭제 성공 얼럿 호출
            disPlayAlert(message: "선택된 음성메모 파일을 성곡적으로 삭제했습니다.")
        } catch {
            // TODO: - 삭제 실패 오류 얼럿 노출
            disPlayAlert(message: "선택된 음성메모 파일 삭제 중 오류가 발생했습니다.")

        }
    }
    private func setIsDisplayRemoveVoiceRecorderAlert(_ isDisPlay: Bool) {
        isDisplayRemoveVoiceRecorderAlert = isDisPlay
    }
    
    private func setErrorAlertMessage(_ message: String){
        alertMessage = message
    }
    //ㅅ
    private func setIsDisplayErrorAlert(_ isDisplay: Bool){
        isDisplayAlert = isDisplay
    }
    private func disPlayAlert(message: String){
        setErrorAlertMessage(message)
        setIsDisplayErrorAlert(true)
    }
    
}

// MARK: - 음성메모 녹음 관련
extension VoiceRecorderViewModel {
    func recordBtnTapped() {
        selectedRecoredFile = nil
        
        if isPlaying {
            // TODO: - 재성 정지 메서드 호출
            stopPlaying()
            // TODO: - 재성 시작 메서드 호출
            startRecording()
        }else if isRecording {
            // TODO: - 녹음 정지 메서드 호출
            stopRecording()
        }else {
            // TODO: 녹음 시작 메서드 호출
            startRecording()
        }
    }
    
    private func startRecording() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("새로운 녹음 \(recordedFiles.count + 1)")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
            audioRecorder?.record()
            self.isRecording = true
        }catch {
            disPlayAlert(message:"음성메모 녹음 중 오류가 발생했습니다." )
        }
    }
    
    private func stopRecording() {
        audioRecorder?.stop()
        self.recordedFiles.append(self.audioRecorder!.url) //녹음이 끝난 뒤 저자ㅓㅇ
        self.isRecording = false
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

//MARK: - 음성메모 재생 관련
extension VoiceRecorderViewModel {
    func startPlaying(recordingURL: URL) {
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: recordingURL)
            audioPlayer?.delegate = self
            audioPlayer?.play() // 실행
            self.isPlaying = true
            self.isPaused = false
            self.progressTimer = Timer.scheduledTimer(
                withTimeInterval: 0.1,
                repeats: true
            ) { _ in
                self.updateCurrentTime()
                }
        } catch {
                disPlayAlert(message: "음성메모 재생 중 오류가 발생했습니다.")
        }
    }
    //시간 없데이트
    private func updateCurrentTime() {
        self.playedTime = audioPlayer?.currentTime ?? 0
    }
    //stop
    private func stopPlaying() {
        audioPlayer?.stop()
        playedTime = 0
        self.progressTimer?.invalidate()
        self.isPaused = false
        self.isPlaying = true
    }
    //일시 정지
    func pausePlaying() {
        audioPlayer?.pause()
        self.isPaused = true
    }
    // 재개
    func resumePlaying() {
        audioPlayer?.play()
        self.isPaused = false
    }
    
    //오디오가 재생 완료 되었을 때
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.isPlaying = false
        self.isPaused = false
    }
    //파일정보 가져오기
    func getFileInfo(for url: URL) -> (Date?,TimeInterval?) {
        let fileManager = FileManager.default // 파일 타입
        var creationDate: Date? //생성 시간
        var duration: TimeInterval? // 기간
        
        do{
            let fileAttributes = try fileManager.attributesOfItem(atPath: url.path) //
            creationDate = fileAttributes[.creationDate] as? Date
        } catch {
            disPlayAlert(message: "선택된 음성메모 파일 정보를 불러올 수 없습니다.")
        }
        
        do{
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            duration = audioPlayer.duration
        }catch{
            disPlayAlert(message: "선택된 음성메모 파일의 재생 시간을 불러올 수 없습니다.")
        }
        return (creationDate,duration)
    }
}
