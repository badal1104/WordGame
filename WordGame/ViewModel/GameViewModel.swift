//
//  GameViewModel.swift
//  WordGame
//
//  Created by Badal Yadav on 02/08/22.
//

import Foundation

protocol GameViewModelDelegate: AnyObject {
    func displayNextWord(with currentWord: GameRoundData)
    func showError(with message: String)
    func displayResult(gameScore: GameScore)
}

final class GameViewModel {
    enum AnswerType {
        case right
        case wrong
        case timeOut
    }
    
    let fileReader: FileReaderProtocol
    private var gameManager: GameManager
    private var wordPairs = [WordPair]()
    private var roundQuestionList = [GameRoundData]()
    var timer: Timer?
    weak var delegate: GameViewModelDelegate?
    var answerType: AnswerType = .timeOut
  
    var isGameEnd: Bool {
        if gameManager.currentRound >= gameManager.numberOfRounds {
            return true
        }
        return false
    }
    
    private var currentWord: GameRoundData {
        return roundQuestionList[gameManager.currentRound]
    }
    
    init(fileReader: FileReaderProtocol =  FileReader(), gameManager: GameManager = GameManager()) {
        self.fileReader =  fileReader
        self.gameManager = gameManager
    }
    
    deinit {
        print(Self.self)
    }
}


// MARK: - Read Words File
extension GameViewModel {
    
    func getFileData() {
        self.fileReader.fetchDataFromFile(with: WordGameConstant.fileName) { [weak self] (result: Result<[WordPair], WordGameError>) in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let wordPairs):
                strongSelf.wordPairs = wordPairs
                strongSelf.generateShuffledRoundData(wordPairs: wordPairs)
                strongSelf.startGame()
            case .failure(let failure):
                strongSelf.handleFileReadFailure(error: failure)
            }
        }
    }
    
    func handleFileReadFailure(error: WordGameError) {
        delegate?.showError(with: error.localizedDescription)
    }
}

// MARK: - Game Events Actions
extension GameViewModel {
    
    func generateShuffledRoundData(wordPairs: [WordPair]) {
        roundQuestionList = GameContentGenerator().generateShuffledData(wordPairs: wordPairs, numberOfRounds: gameManager.numberOfRounds)
    }
    
    func startGame() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Call method with delay because GameViewController safeAreaLayoutGuide not updating.
            self.nextQuestion()
        }
    }
    
    func nextQuestion() {
        if wordPairs.isEmpty {
            stopTimer()
            return
        }
        if isGameEnd {
            stopTimer()
            result()
        } else {
            resetTimer()
            delegate?.displayNextWord(with: currentWord)
        }
    }
    
    func result() {
        print("GameEnd")
        print(gameManager.gameScore.description)
        delegate?.displayResult(gameScore: gameManager.gameScore)
        resetGameManager()
    }
    
    func restartGame() {
        generateShuffledRoundData(wordPairs: wordPairs)
        nextQuestion()
    }
    
    func resetGameManager(){
        gameManager.reset()
    }
}



// MARK: - Action (Right, Wrong and TimeOut)
extension GameViewModel {
    
    func answerSelectionAction(answerType: AnswerType) {
        self.answerType = answerType
        scoreCalculation()
        gameManager.currentRound += 1
        nextQuestion()
    }
}

// MARK: - Score Calculation
extension GameViewModel {
    
    func scoreCalculation() {
        switch answerType {
        case .right:
            rightAnswerCalculation()
        case .wrong:
            wrongAnswerCalculation()
        case .timeOut:
            timeOutAnswerCalculation()
        }
    }
    
    fileprivate func rightAnswerCalculation() {
        if currentWord.isTranslationCorrect {
            gameManager.gameScore.correctAnswer += 1
        } else if currentWord.isTranslationCorrect == false {
            gameManager.gameScore.wrongAnswer += 1
        }
    }
    
    fileprivate func wrongAnswerCalculation() {
        if currentWord.isTranslationCorrect == false {
            gameManager.gameScore.correctAnswer += 1
        } else if currentWord.isTranslationCorrect {
            gameManager.gameScore.wrongAnswer += 1
        }
    }
    
    fileprivate func timeOutAnswerCalculation() {
        gameManager.gameScore.unattempt += 1
    }
    
}

// MARK: - Timer Actions
extension GameViewModel {
    
    func startTimer() {
        if timer == nil {
            timer =  Timer.scheduledTimer(withTimeInterval: self.gameManager.durationOfRound, repeats: true) { [weak self] _ in
                self?.answerSelectionAction(answerType: .timeOut)
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        startTimer()
    }
    
}
