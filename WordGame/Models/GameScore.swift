//
//  GameScore.swift
//  WordGame
//
//  Created by Badal Yadav on 05/08/22.
//

import Foundation

struct GameScore: CustomStringConvertible {
    var correctAnswer = 0
    var wrongAnswer = 0
    var unattempt = 0
    
    mutating func resetScore() {
         correctAnswer = 0
         wrongAnswer = 0
         unattempt = 0
    }
    
    var description: String {
        let result = "\(Constant.correct) \(correctAnswer) \n\(Constant.wrong) \(wrongAnswer) \n\(Constant.unattempt) \(unattempt)"
        return result
    }
}
