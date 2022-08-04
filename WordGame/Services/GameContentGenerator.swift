//
//  GameContentGenerator.swift
//  WordGame
//
//  Created by Badal Yadav on 03/08/22.
//

import Foundation

struct GameContentGenerator {
    
    func generateShuffledData(wordPairs: [WordPair], numberOfRounds: Int) -> [GameRoundData] {
        let shuffledMaxRoundWordPairs = wordPairs.shuffled().prefix(numberOfRounds)
        let halfRoundCount = numberOfRounds / 2
        var correctWordPairs = shuffledMaxRoundWordPairs.prefix(halfRoundCount).map {
            return GameRoundData(englishWord: $0.english, spanishWord: $0.spanish, isTranslationCorrect: true)
        }
        let remainingRoundsCount = numberOfRounds - halfRoundCount
        let remainingWordPairs = shuffledMaxRoundWordPairs.suffix(remainingRoundsCount)
        
        let allSpanishWords = Set(wordPairs.map { $0.spanish })
        let mixOfCorrectOrIncorrectWordPairs: [GameRoundData] = remainingWordPairs.map {
            let spanishWord = allSpanishWords.randomElement() ?? $0.spanish
            return GameRoundData(englishWord: $0.english, spanishWord: spanishWord, isTranslationCorrect: spanishWord == $0.spanish)
        }
        correctWordPairs.append(contentsOf: mixOfCorrectOrIncorrectWordPairs)
        
        return correctWordPairs.shuffled()
    }
    
    
}
