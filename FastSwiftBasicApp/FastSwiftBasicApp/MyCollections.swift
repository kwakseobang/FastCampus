//
//  MyCollections.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/13/24.
//

import SwiftUI

struct MyCollections: View {
    var foods: [String] = ["eggs","bananas","apple"]
    var jazzs: Set<String> = ["vivivivi","dadadad","ddgdgs"]
    var hiphop: Set<String> = ["rap","kwak","hinf"]
    var koEngDict: [String:String] = ["name":"kwakmunsu","sex":"male"]
    var body: some View {
        VStack{
            Text(koEngDict["name"]!)
            Text(koEngDict["sex"]!)
        }
       
    }
}

#Preview {
    MyCollections()
}
