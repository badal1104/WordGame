//
//  ViewController.swift
//  WordGame
//
//  Created by Badal Yadav on 30/07/22.
//

import UIKit

final class GameViewController: UIViewController {

    let gameViewModel: GameViewModel?
    
    private let headerLabel = UILabel()
    private let englishWordLabel = UILabel()
    private let spanishWordLabel = UILabel()
    private var spanishWordLabelTopConstraint: NSLayoutConstraint!
    
    private let correctButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(GameViewConstant.correct, for: .normal)
        return button
    }()
    
    private let wrongButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(GameViewConstant.wrong, for: .normal)
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = GameViewConstant.title
        setupUI()
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


// MARK: - Layout
extension GameViewController {
    
    private func setupUI() {
        createHeaderLabel()
        createEnglishWordLabel()
        createSpanishWordLabel()
        setupButtonStack()
    }
    
    private func createHeaderLabel() {
        headerLabel.numberOfLines = 2
        headerLabel.text = GameViewConstant.headerMessage
        headerLabel.font = UIFont.boldSystemFont(ofSize: 26)
        headerLabel.textAlignment = .center
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)
        addHeaderLabelConstraint()
    }
    
    private func addHeaderLabelConstraint() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
    
    private func createEnglishWordLabel() {
        englishWordLabel.textAlignment = .center
        englishWordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(englishWordLabel)
        addEnglishLabelConstraint()
    }
    
    private func addEnglishLabelConstraint() {
        NSLayoutConstraint.activate([
            englishWordLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 24),
            englishWordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            englishWordLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
    
    private func createSpanishWordLabel() {
        spanishWordLabel.textAlignment = .center
        spanishWordLabel.translatesAutoresizingMaskIntoConstraints = false
        spanishWordLabel.font = .italicSystemFont(ofSize: 16)
        
        view.addSubview(spanishWordLabel)
        addSpanishLabelConstraint()
    }
    
    private func addSpanishLabelConstraint() {
        spanishWordLabelTopConstraint = spanishWordLabel.topAnchor.constraint(equalTo: englishWordLabel.bottomAnchor, constant: 12)
        
        NSLayoutConstraint.activate([
            spanishWordLabelTopConstraint,
            spanishWordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            spanishWordLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
    }
    
    // MARK: - Button Stack
    private func setupButtonStack() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        addButtonsInStack()
    }
    
    private func addButtonsInStack() {
        setButtonProperties(button: correctButton)
        setButtonProperties(button: wrongButton)
        [correctButton, wrongButton].forEach {buttonStackView.addArrangedSubview($0)}
        addActionOnButton()
    }
    
    private func setButtonProperties(button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
    }
}

// MARK: - GameViewModel Delagate
extension GameViewController: GameViewModelDelegate {
    func showError(with message: String) {
        
    }
    
    func displayNextWord(with currentWord: GameRoundData) {
        print(currentWord)
        englishWordLabel.text = currentWord.englishWord
        spanishWordLabel.text = currentWord.spanishWord
        animateSpanishWord()
    }
    
    func displayResult(gameScore: GameScore) {
        let score = gameScore.description
        let alert = UIAlertController(title: GameViewConstant.score, message: score, preferredStyle: .alert)
        let quit = UIAlertAction(title: GameViewConstant.quit, style: .default) { _ in
            exit(EXIT_SUCCESS)
        }
        let restart = UIAlertAction(title: GameViewConstant.restart, style: .default) { [weak self]_ in
            self?.gameViewModel?.restartGame()
        }
        
        alert.addAction(restart)
        alert.addAction(quit)
        present(alert, animated: true)
    }
}

// MARK: - Spanish Word Animation
extension GameViewController {
    
    private func animateSpanishWord(with duration: TimeInterval = 5.0) {
        spanishWordLabel.layer.removeAllAnimations()
        self.spanishWordLabelTopConstraint?.constant = 12
        view.layoutIfNeeded()
        let animationShift = buttonStackView.frame.origin.y - spanishWordLabel.frame.origin.y
        spanishWordLabel.alpha = 1
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: []) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.spanishWordLabelTopConstraint?.constant = animationShift
            strongSelf.view.layoutIfNeeded()
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3, animations: {
                strongSelf.spanishWordLabel.alpha = 0
            })
        }
    }
}

// MARK: - Correct & Wrong Button Actions
extension GameViewController {
   private func addActionOnButton() {
        addActionOnCorrectButton()
        addActionOnWrongButton()
    }
    
    private func addActionOnCorrectButton() {
        correctButton.addTarget(self, action: #selector(correctAnswer(sender:)), for: .touchUpInside)
    }
    
    private func addActionOnWrongButton() {
        wrongButton.addTarget(self, action: #selector(wrongAnswer(sender:)), for: .touchUpInside)
    }
    
    @objc func correctAnswer(sender: UIButton) {
        gameViewModel?.answerSelectionAction(answerType: .right)
    }
    
    @objc func wrongAnswer(sender: UIButton) {
        gameViewModel?.answerSelectionAction(answerType: .wrong)
    }
}
