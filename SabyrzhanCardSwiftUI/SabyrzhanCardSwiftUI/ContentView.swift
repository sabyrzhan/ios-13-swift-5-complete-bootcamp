//
//  ContentView.swift
//  SabyrzhanCardSwiftUI
//
//  Created by Sabyrzhan Tynybayev on 04.07.2020.
//  Copyright © 2020 Sabyrzhan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(UIColor(red: 0.16, green: 0.50, blue: 0.73, alpha: 1.00))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("ava")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150.0, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                Text("Sabyrzhan Tynybayev Kenzhebekovich")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .bold()
                    .foregroundColor(Color("TextColor"))
                    .lineLimit(0)
                Text("Java Developer")
                    .foregroundColor(Color("TextColor"))
                    .font(.system(size: 25))
                Divider()
                InfoView(text: "+7 777 1234567", imageName: "phone.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


