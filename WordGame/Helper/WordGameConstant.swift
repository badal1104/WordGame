//
//  WordGameConstant.swift
//  WordGame
//
//  Created by Badal Yadav on 02/08/22.
//

import Foundation

struct WordGameConstant {
    static let fileName = "words.json"
 }

// MARK: - GameViewController Constant
extension GameViewController {
    enum GameViewConstant {
        static let title = "Word game"
        static let headerMessage = "Is that a correct word pair translation?"
        static let score = "Score"
        static let quit = "Quit"
        static let restart = "Restart"
        static let correct = "Correct"
        static let wrong = "Wrong"
        static let padding = 8.0
        static let mediumPadding = 2*padding
        static let largePadding = 3*padding
        static let stackViewHeight = 40.0
    }
}


// MARK: - WordGameError Constant
extension WordGameError {
        static let generalMessage = "Something went wrong, please try again later"
        static let unableToReadFileMessage = "Problem in reading file, please validate it."
        static let corruptDataMessage = "Empty response data"
        static let decodingFailMessage = "Unable to decode response object"
}

extension GameScore {
    enum Constant {
        static let correct = "correctAnswer:"
        static let wrong = "wrongAnswer:"
        static let unattempt = "unattempt:"
    }
}
