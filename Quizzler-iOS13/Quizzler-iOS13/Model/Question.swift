//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Sabyrzhan Tynybayev on 5/31/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var answer: [String]
    var correctAnswer: String
    
    init(q text: String, a answer: [String], correctAnswer: String) {
        self.text = text
        self.answer = answer
        self.correctAnswer = correctAnswer
    }
}
