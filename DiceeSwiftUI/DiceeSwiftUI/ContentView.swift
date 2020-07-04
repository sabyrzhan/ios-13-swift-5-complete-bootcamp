//
//  ContentView.swift
//  DiceeSwiftUI
//
//  Created by Sabyrzhan Tynybayev on 04.07.2020.
//  Copyright © 2020 Sabyrzhan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var leftDiceNumber = 1
    @State var rightDiceNumber = 1
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("diceeLogo")
                Spacer()
                HStack {
                    DiceView(number:leftDiceNumber)
                    DiceView(number:rightDiceNumber)
                }
                .padding(.horizontal)
                Spacer()
                Button(action: {
                    self.leftDiceNumber = Int.random(in: 1...6)
                    self.rightDiceNumber = Int.random(in: 1...6)
                }) {
                    Text("Roll")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }.background(Color.red)
                    .padding(.bottom)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DiceView: View {
    var number: Int
    var body: some View {
        Image("dice\(number)")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding()
    }
}
