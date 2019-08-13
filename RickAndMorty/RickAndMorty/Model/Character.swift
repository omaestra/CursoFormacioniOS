//
//  Character.swift
//  RickAndMorty
//
//  Created by omaestra on 13/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}

//struct Character: Codable {
//    var id: Int
//    var name: String
//    var status: CharacterStatus
//    var image: String
//}
