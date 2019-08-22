//
//  TrafficLightPresenter.swift
//  MVPTrafficLights
//
//  Created by omaestra on 22/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

protocol TrafficLightViewDelegate: NSObjectProtocol {
    func displayTrafficLight(description: String)
}

class TrafficLightPresenter {
    private let trafficLightService: TrafficLightService
    weak private var trafficLightViewDelegate: TrafficLightViewDelegate?
    
    init(service: TrafficLightService) {
        self.trafficLightService = service
    }
    
    func setViewDelegate(delegate: TrafficLightViewDelegate?) {
        self.trafficLightViewDelegate = delegate
    }
    
    func trafficLightColorSelected(color: String) {
        trafficLightService.getTrafficLight(colorName: color) { [weak self] (trafficLight) in
            if let trafficLight = trafficLight {
                self?.trafficLightViewDelegate?.displayTrafficLight(description: trafficLight.description)
            }
        }
    }
}
