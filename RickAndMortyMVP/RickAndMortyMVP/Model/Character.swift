//
//  Character.swift
//  RickAndMorty
//
//  Created by Usuario on 14/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation
import UIKit


struct Character: Codable, Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum Status: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
        
        var color: UIColor {
            switch self {
            case .alive:
                return #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
            case .dead:
                return #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
            case .unknown:
                return #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
            }
        }
    }
    
    var id: Int
    var name: String
    var status: Status
    var species: String
    var type: String
    var image: String
    var gender: String
    var origin: [String: String]
    var location: [String: String]
    var episode: [String]
}
