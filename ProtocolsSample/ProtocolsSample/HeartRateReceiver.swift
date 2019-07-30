//
//  HeartRateReceiver.swift
//  ProtocolsSample
//
//  Created by omaestra on 29/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

protocol HeartRateReceiverDelegate {
    func heartRateUpdated(to bpm: Int)
}

class HeartRateReceiver {
    
    var delegate: HeartRateReceiverDelegate?
    
    var currentHR: Int? {
        didSet {
            if let currentHR = self.currentHR {
                print("The most recent heart rate reading is \(currentHR).")
                self.delegate?.heartRateUpdated(to: currentHR)
            } else {
                print("Looks like we can't pick up a heart rate.")
            }
        }
    }
    
    func startHeartRateMonitoringExample() {
        
        for _ in 1...10 {
            let randomHR = 60 + Int(arc4random_uniform(UInt32(15)))
            
            self.currentHR = randomHR
            Thread.sleep(forTimeInterval: 2)
        }
    }
}
