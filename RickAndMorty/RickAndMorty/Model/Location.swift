//
//  Location.swift
//  RickAndMorty
//
//  Created by Usuario on 14/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

struct Location: Codable {
    var id: Int
    var name: String
    var type: String?
    var dimension: String?
    var residents: [String]?
    var url: String?
    var created: String?
}
