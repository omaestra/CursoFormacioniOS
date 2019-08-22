//
//  TrafficLightService.swift
//  MVPTrafficLights
//
//  Created by omaestra on 22/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

class TrafficLightService {
    
    func getTrafficLight(colorName:(String), callback: @escaping (TrafficLight?) -> Void) {
        let trafficLights = [TrafficLight(colorName: "Red", description: "Stop"),
                             TrafficLight(colorName: "Green", description: "Go"),
                             TrafficLight(colorName: "Yellow", description: "About to change to red")
        ]
        
        if let foundTrafficLight = trafficLights.first(where: {$0.colorName == colorName}) {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                callback(foundTrafficLight)
            }
        } else {
            callback(nil)
        }
    }
}
