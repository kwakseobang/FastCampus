//
//  ListLoop.swift
//  WarmUp
//
//  Created by 곽서방 on 1/14/24.
//

import SwiftUI
/*
 state
 데이터의 상태를 나타내는 state
 struct에서 필요한 기능
 화면이 새로 그려져야 할 떄를 알려준다.
 */

//모델링          반복될수있다
struct Fruits: Hashable{
    let name: String
    let matchFruitName: String
    let price : Int
}

struct ListLoop: View {
   @State var favoriteFruits = [
        Fruits(name: "Apple", matchFruitName: "Ellonb", price: 1000),
        Fruits(name: "Banana", matchFruitName: "Banana", price: 5000),
        Fruits(name: "Apple", matchFruitName: "Ellonb", price: 1000),
        Fruits(name: "Double mango", matchFruitName: "Banana", price: 1000),
        Fruits(name: "Carrot", matchFruitName: "Banana", price: 4000),
        Fruits(name: "Ellonb", matchFruitName: "Ellonb", price: 9000),
        Fruits(name: "Carrot", matchFruitName: "Apple", price: 300),
    
    
    ]
    @State var fruitName : String = ""
    var body: some View {
        NavigationStack { //10개까지만 들어감
            VStack{
                HStack{
                    TextField("insert fruit name", text: $fruitName) //$를 이용하여 바인딩으로 연결
                    Button{ //action
                        favoriteFruits.append(Fruits(name: fruitName, matchFruitName: "apple", price: 10000))
                    }label: {
                        Text("insert")
                            .padding()
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                List{
                    ForEach(favoriteFruits, id: \.self) { item in
                        VStack(alignment: .leading) {
                            Text("name: \(item.name)")
                            Text("match: \(item.matchFruitName)")
                            Text("price: \(item.price)")
                        }
                    }.onDelete(perform: { indexSet in  //삭제 애플에서 제공하는.. 해당 리스트에서 클릭 시 인덱스가 indexSet로 넘어온다.
                        favoriteFruits.remove(atOffsets: indexSet)
                    })
                }
                .navigationTitle("Fruit List")
            }
        }
    }
}

#Preview {
    ListLoop()
}
