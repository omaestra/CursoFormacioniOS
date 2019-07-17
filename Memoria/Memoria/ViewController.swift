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
    
    var repeticiones = 0 {
        didSet {
            countLabel.text = "Nro. Repeticiones: \(repeticiones)"
        }
    }
    
    var emojiChoices = ["🎃", "👻", "🎃", "👻"]
    
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

    @IBAction func cardPressed(_ sender: UIButton) {
        repeticiones += 1
        
        if let cardIndex = buttons.firstIndex(of: sender) {
            flipCard(emoji: emojiChoices[cardIndex], on: sender)
        } else {
            debugPrint("Choosen card does not exit.")
        }
    }

}

