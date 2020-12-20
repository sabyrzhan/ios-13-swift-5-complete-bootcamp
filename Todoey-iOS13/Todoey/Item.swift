//
//  Item.swift
//  Todoey
//
//  Created by Sabyrzhan Tynybayev on 12/20/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

class Item: Codable {
    var title: String?
    var done: Bool
    
    init(title: String, done: Bool = false) {
        self.title = title
        self.done = done
    }
}
