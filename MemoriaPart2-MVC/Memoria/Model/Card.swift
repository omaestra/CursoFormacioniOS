//
//  Card.swift
//  MemoriaPart2-MVC
//
//  Created by omaestra on 17/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

struct Card {
    var id: String
    var isMatched: Bool = false
    var isFaceUp: Bool = false
    
    init() {
        self.id = UUID().uuidString
    }
}
