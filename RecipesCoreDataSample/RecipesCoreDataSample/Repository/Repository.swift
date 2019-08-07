//
//  Repository.swift
//  RecipesCoreDataSample
//
//  Created by omaestra on 04/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype T
    
    func getAll() -> [T]?
    func get(identifier: Int) -> T?
    func create() -> T
    func update(model: T) -> Bool
    func delete(model: T) -> Bool
}
