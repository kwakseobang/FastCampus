//
//  VariableType.swift
//  FastSwiftBasicApp
//
//  Created by 곽서방 on 1/13/24.
//

import SwiftUI

struct VariableType: View {
    var name: String = "Kwak"
    var age: Int = 20
    var height: Float = 181.9
    var havePet: Bool = false
    var body: some View {
        VStack{
            Text("\(name)")
            Text("\(age)")
            Text("\(height)")
            Text("\(havePet.description)")
        }
    }
}

struct VariableType_Previews: PreviewProvider {
    static var previews: some View {
        VariableType()
    }
}
