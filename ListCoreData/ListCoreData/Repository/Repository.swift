//
//  Repository.swift
//  List
//
//  Created by omaestra on 05/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype T
    
    func getAll() -> [T]
    func getById(id: String) -> T
    func insert(item: T)
    func update(item: T)
    func clean()
    func delete(item: T)
}
