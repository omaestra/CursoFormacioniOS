//
//  Memoria.swift
//  MemoriaPart2-MVC
//
//  Created by omaestra on 17/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

class Memoria {
    var cards = [Card]()
    var indexOfFacedUpCard: Int?
    
    init?(numberOfCards: Int) {
        if (numberOfCards % 2) == 0 {
            for _ in 1...numberOfCards/2 {
                let card = Card()
                cards += [card, card]
            }
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfFacedUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].id == cards[index].id {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfFacedUpCard = nil    // not one and only ...
            } else {
                // either no card or two cards face up
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfFacedUpCard = index
            }
            
        }
    }
}
