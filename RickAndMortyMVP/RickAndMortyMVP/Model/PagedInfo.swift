//
//  PagedInfo.swift
//  RickAndMorty
//
//  Created by Usuario on 14/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

struct PagedData<T: Codable>: Codable {
    
    struct Meta: Codable {
        var count: Int
        var pages: Int
        var next: String
        var prev: String
    }
    
    let info: Meta
    let results: [T]
}
