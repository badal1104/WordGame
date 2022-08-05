//
//  GameScore.swift
//  WordGame
//
//  Created by Badal Yadav on 05/08/22.
//

import Foundation

struct GameScore {
    var correctAnswer = 0
    var wrongAnswer = 0
    var unattempt = 0
    
    mutating func resetScore() {
         correctAnswer = 0
         wrongAnswer = 0
         unattempt = 0
    }
}
