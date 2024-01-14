//
//  Exception.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI

struct Exception: View {
    @State var inputNum = ""
    @State var resultNum :Float = 0
    var body: some View {
        VStack{
            TextField("나눌 숫자를 입력해주세요", text: $inputNum)
            Text("결과: \(resultNum)")
            Button {
                //do catch 안에서 해야됨 try는 시도해봐라 catch는 에러 발생 시
                do{
                    try  resultNum = divideTen((Float(inputNum) ?? 1.0))
                }  catch DivideError.divideByZero {
                    print("0으로 나누면 안됩니다.")
                    resultNum = -999
                    inputNum = "잘못된 입력입니다."
                } catch {
                    print(error.localizedDescription)
                }
               
            }label: {
                Text("나누기")
            }

        }
    }
    //error를 던질 수 있는 함수(throws )
    func divideTen(_ input: Float) throws -> Float {
        // 에러 처리
        if input == 0 {
            //해당 오류를 던진다.
            throw DivideError.divideByZero
        } else {
            return 10 / input
        }
    }
                      
}
//사용자 정의 에러
enum DivideError: Error {
    case divideByZero
}

#Preview {
    Exception()
}
