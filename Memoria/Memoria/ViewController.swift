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

    @IBAction func cardPressed(_ sender: UIButton) {
        repeticiones += 1
        let index = buttons.index(of: sender)!
        
        DispatchQueue.main.async {
            sender.setTitle(self.emojiChoices[index], for: .normal)
            sender.backgroundColor = sender.backgroundColor == UIColor.black ? UIColor.orange : UIColor.black
            sender.setTitle(sender.backgroundColor ==  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ? nil : self.emojiChoices[index], for: .normal)
        }
    }

}

