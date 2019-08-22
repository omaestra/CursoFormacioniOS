//
//  ViewController.swift
//  MVPTrafficLights
//
//  Created by omaestra on 22/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let trafficLightPresenter = TrafficLightPresenter(service: TrafficLightService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trafficLightPresenter.setViewDelegate(delegate: self)
    }
    
    @IBAction func redLightAction(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(color: "Red")
    }
    
    @IBAction func yellowLightAction(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(color: "Yellow")
    }
    
    @IBAction func greenLightAction(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(color: "Green")
    }
}

extension ViewController: TrafficLightViewDelegate {
    func displayTrafficLight(description:(String)) {
        descriptionLabel.text = description
    }
}
