//
//  GameManager.swift
//  WordGame
//
//  Created by Badal Yadav on 05/08/22.
//

import Foundation

struct GameManager: CustomStringConvertible {
    let numberOfRounds = 10
    let durationOfRound: TimeInterval = 5.0
    var currentRound = 0
    var gameScore = GameScore()
    var description: String {
        let result = "correctAnswer: \(gameScore.correctAnswer) \nwrongAnswer: \(gameScore.wrongAnswer) \nunattempt: \(gameScore.unattempt)"
        return result
    }
    
    mutating func reset() {
        currentRound = 0
        gameScore.resetScore()
    }
}
