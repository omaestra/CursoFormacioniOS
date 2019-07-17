//
//  ViewController.swift
//  Memoria
//
//  Created by omaestra on 17/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    lazy var game = Memoria(numberOfCards: buttons.count)
    
    var repeticiones = 0 {
        didSet {
            countLabel.text = "Nro. Repeticiones: \(repeticiones)"
        }
    }
    
    var emoji = [String: String]()
    var emojiChoices = ["🎃", "🐶", "👻", "🍎", "🕺", "💃"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countLabel.text = "Count: \(repeticiones)"
        self.countLabel.textColor = #colorLiteral(red: 0.3984073997, green: 0.7686031461, blue: 1, alpha: 1)
    }
    
    private func flipCard(emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle(nil, for: .normal)
            button.backgroundColor = UIColor.black
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = UIColor.orange
        }
    }
    
    func updateUI() {
        for index in buttons.indices {
            let button = buttons[index]
            guard let card = game?.cards[index] else { break }
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
            emoji[card.id] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.id] ?? "?"
    }

    @IBAction func cardPressed(_ sender: UIButton) {
        repeticiones += 1
        
        if let cardIndex = buttons.firstIndex(of: sender) {
//            flipCard(emoji: emojiChoices[cardIndex], on: sender)
            game?.chooseCard(at: cardIndex)
            updateUI()
        } else {
            debugPrint("Choosen card does not exit.")
        }
    }

}

