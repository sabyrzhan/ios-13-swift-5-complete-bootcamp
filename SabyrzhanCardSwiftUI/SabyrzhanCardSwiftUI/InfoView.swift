//
//  InfoView.swift
//  SabyrzhanCardSwiftUI
//
//  Created by Sabyrzhan Tynybayev on 04.07.2020.
//  Copyright © 2020 Sabyrzhan. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    var text: String
    var imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 100)
            .fill(Color.white)
            .frame(height: 50, alignment: .center)
            .overlay(HStack {
                Image(systemName: imageName)
                    .foregroundColor(.green)
                Text(text)
                    .fontWeight(.bold)
                .foregroundColor(Color("TextColor"))
            })
            .padding(.all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Hello", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
}
