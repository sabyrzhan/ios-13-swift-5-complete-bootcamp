//
//  PostData.swift
//  HackerNewsApp
//
//  Created by Sabyrzhan Tynybayev on 04.07.2020.
//  Copyright © 2020 Sabyrzhan. All rights reserved.
//

import Foundation

struct Results: Codable {
    var hits: [Post]
}

struct Post: Codable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let url: String?
    let title: String
    let points: Int
}
