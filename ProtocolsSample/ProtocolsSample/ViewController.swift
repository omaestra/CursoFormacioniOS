//
//  ViewController.swift
//  ProtocolsSample
//
//  Created by omaestra on 29/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heartRateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let heartRateReceiver = HeartRateReceiver()
        heartRateReceiver.delegate = self
        heartRateReceiver.startHeartRateMonitoringExample()
    }


}

extension ViewController: HeartRateReceiverDelegate {
    func heartRateUpdated(to bpm: Int) {
        DispatchQueue.main.async {
            self.heartRateLabel.text = "\(bpm)"
        }
        print("The user has been shown a heart rate of \(bpm)")
    }
}
