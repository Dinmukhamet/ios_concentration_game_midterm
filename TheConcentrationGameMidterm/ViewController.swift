//
//  ViewController.swift
//  TheConcentrationGameMidterm
//
//  Created by Dinmukhamet Igissinov on 10/31/20.
//

import UIKit
import SCLAlertView

class ViewController: UIViewController {
    
    override func loadView() {
        let customView = UIView()
        customView.backgroundColor = .black
        
        view = customView
    }
        
    let emojiList = ["🍔", "🍙", "🍪", "🎲", "🐬", "🌵", "🍉", "🌸"]
    
    var emojiButtons = [EmojiButton]()
    
    lazy var gameCards = GameCards(cards: emojiButtons)

    var pressedButtons = [EmojiButton]()
    var guessedButtons = [EmojiButton?]()
    
    
    var cardButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let fieldSize = 4
        
        
        let emojies = emojiList + emojiList
        for i in 0..<emojies.count {
            emojiButtons.append(EmojiButton(id: i, emoji: emojies[i], isPressed: false, def: ""))
        }
        
        for cardButtonIndex in 0..<gameCards.cards.count {
            let cardButton = UIButton()
            cardButton.tag = gameCards.cards[cardButtonIndex].id
            cardButton.setTitle(gameCards.cards[cardButtonIndex].def, for: .normal)
            cardButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            cardButton.backgroundColor = .orange
            cardButtons.append(cardButton)
            cardButton.addTarget(self, action: #selector(handleEmojiButtonTap(_:)), for: .touchUpInside)
        }
        
        let cardsGridStackView = UIStackView()
        cardsGridStackView.axis = .vertical
        cardsGridStackView.distribution = .fillEqually
        cardsGridStackView.spacing = 12
        cardsGridStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let gameTitleLabel = UILabel()
        gameTitleLabel.text = "The concentration game"
        gameTitleLabel.textColor = .orange
        gameTitleLabel.textAlignment = .center
        cardsGridStackView.addArrangedSubview(gameTitleLabel)
        
        var cardsView: UIStackView!
        for cardButtonIndex in 0..<cardButtons.count {
            if cardButtonIndex % 4 == 0 {
                cardsView = UIStackView()
                cardsView.axis = .horizontal
                cardsView.distribution = .fillEqually
                cardsView.spacing = 12
                cardsGridStackView.addArrangedSubview(cardsView)
            }
            let cardButton = cardButtons[cardButtonIndex]
//            cardButton.addConstraint(NSLayoutConstraint(item: cardButton, attribute: .height, relatedBy: .equal, toItem: cardButton, attribute: .width, multiplier: 1, constant: 0))

            cardsView.addArrangedSubview(cardButton)
        }
        view.addSubview(cardsGridStackView)

        let cardsViewConstraints = [
            gameTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            cardsGridStackView.topAnchor.constraint(equalTo: view.topAnchor),
            cardsGridStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            cardsGridStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            cardsGridStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(cardsViewConstraints)
        
    }
    
    @IBAction func handleEmojiButtonTap(_ sender: UIButton) {
        for emojiButton in emojiButtons{
            if sender.tag == emojiButton.id {
                sender.setTitle(emojiButton.emoji, for: .normal)
                sender.backgroundColor = .darkGray
                if guessedButtons.contains(emojiButton) {
                    continue
                }
                pressedButtons.append(emojiButton)
            }
            
        }

        clearScreen()
    }
    
    func clearScreen() -> Void {
        for cardButton in cardButtons {
            var skip: Bool = false
            for emojiButton in emojiButtons {
                if cardButton.tag == emojiButton.id {
                    if guessedButtons.contains(emojiButton) || pressedButtons.contains(emojiButton) {
                        skip = true
                        break
                    }
                }
            }

            if skip{
                continue
            } else {
                cardButton.setTitle("", for: .normal)
                cardButton.backgroundColor = .orange
            }
            
        }
        if pressedButtons.count == 2 {
            let a: EmojiButton! = pressedButtons.first
            let b: EmojiButton! = pressedButtons.last
            if a!.emoji == b!.emoji {
                guessedButtons.append(contentsOf: [a, b])
            }
            pressedButtons.removeAll()
        }
        
        if guessedButtons.count == emojiButtons.count {
            let alertController = UIAlertController(title: "Congratulations", message: "You've won!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: handleAlertAction)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func handleAlertAction(alert: UIAlertAction) {
        guessedButtons.removeAll()
        emojiButtons.removeAll()
        updateValues()
    }
    
    func updateValues() -> Void {
        var emojies = emojiList + emojiList
        emojies = emojies.shuffled()
        for i in 0..<emojies.count {
            emojiButtons.append(EmojiButton(id: i, emoji: emojies[i], isPressed: false, def: ""))
        }
        for i in 0..<emojiButtons.count {
            let cardButton = cardButtons[i]
            let emojiButton = emojiButtons[i]
            cardButton.tag = emojiButton.id
            cardButton.setTitle("", for: .normal)
        }
    }
    
}


