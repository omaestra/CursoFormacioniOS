//
//  ViewController.swift
//  DocumentationComments
//
//  Created by omaestra on 23/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let car = Car(make: "", model: "", year: 1991)
        car.travel(distance: 10)
        print(car.description)
    }


}

