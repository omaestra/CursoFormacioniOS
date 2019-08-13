//
//  PagedCharacters.swift
//  RickAndMorty
//
//  Created by omaestra on 13/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

struct PagedCharacters: Codable {
    struct Meta: Codable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String
    }
    
    private enum CodingKeys: String, CodingKey {
        case meta = "info"
        case results
    }
    
    let meta: Meta
    let results: [Character]
}

struct Character: Codable {
    var id: Int
    var name: String
//    var status: CharacterStatus
    var image: String
}

//struct Results<T: Codable>: Codable {
//    let data: [T]
//
//    private enum CodingKeys: String, CodingKey {
//        case data = "results"
//    }
//}


struct PagedData<T: Codable>: Codable {
    struct Meta: Codable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String
    }
    
    private enum CodingKeys: String, CodingKey {
        case meta = "info"
        case results
    }
    
    let meta: Meta
    let results: [T]
}
