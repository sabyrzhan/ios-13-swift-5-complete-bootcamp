//
//  ContentView.swift
//  HackerNewsApp
//
//  Created by Sabyrzhan Tynybayev on 04.07.2020.
//  Copyright © 2020 Sabyrzhan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(self.networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text(String(format: "%4d", post.points))
                        Text(post.title)
                    }
                }
            }.navigationBarTitle("Hacker News Reader")
        }.onAppear {
            self.networkManager.ferchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
