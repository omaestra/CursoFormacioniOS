//
//  ViewController.swift
//  AutoLayoutSample
//
//  Created by omaestra on 19/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let fighter = Fighter.init()
        fighter.fire()
        fighter.fire()
        fighter.fire()
        fighter.fire()
        fighter.fire()
        fighter.fire()
        print(fighter.remainingFirePower)
    }
    
    class Spaceship {
        var name: String = ""
        var health = 100
        var position = 0
        
        func moveLeft() {
            position -= 1
        }
        
        func moveRight() {
            position += 1
        }
        
        func wasHit() {
            health -= 5
        }
    }
    
    class Fighter: Spaceship {
        var weapon = ""
        var remainingFirePower = 5
        
        func fire() {
            if remainingFirePower > 0 {
                remainingFirePower -= 1
            } else {
                print("You have no more fire power.")
            }
        }
    }


}

