

import SwiftUI

struct MyCar: View {
    var myCar: KIA = KIA()
    @State var speed: Int = 100
    var body: some View {
        VStack {
            Text("speed: \(speed)")
            HStack{
                Button{
                    speed = myCar.speedDown(with: speed)
                }label: {
                    Text("감속")
                }
                Button{
                    speed = myCar.speedUp(with: speed)
                }label: {
                    Text("증속")
                }
            }
        }
    }
}
//프로토콜 채택
struct KIA: Driveable {
    func speedDown(with sp: Int) -> Int {
        
        return sp - 1
    }
    func speedUp(with sp: Int) -> Int {
        
        return sp + 1
    }
    
    
}
//프로토콜 설계
protocol Driveable {
    //이 프로토콜을 채택한 구조체나 클래스는 해당 메서드를 만드시 구현
    func speedDown(with sp: Int) -> Int
    func speedUp(with sp: Int) -> Int
}

#Preview {
    MyCar()
}
