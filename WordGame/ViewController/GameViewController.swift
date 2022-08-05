//
//  ViewController.swift
//  WordGame
//
//  Created by Badal Yadav on 30/07/22.
//

import UIKit

final class GameViewController: UIViewController {

    let gameViewModel: GameViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        gameViewModel?.delegate = self
        gameViewModel?.getFileData()
    }

    init(viewModel: GameViewModel) {
        gameViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - GameViewModel Delagate
extension GameViewController: GameViewModelDelegate {
    func showError(with message: String) {
        
    }
    
    func displayNextWord(with currentWord: GameRoundData) {
        print(currentWord)
    }
    
    func displayResult(gameScore: GameScore) {
    
    }
}
