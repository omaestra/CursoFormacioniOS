//
//  Athlete.swift
//  FavoriteAthlete
//
//  Created by omaestra on 25/07/2019.
//

import Foundation

struct Athlete {
    var name: String
    var age: Int
    var league: String
    var team: String
}

extension Athlete: CustomStringConvertible {
    var description: String {
        return "\(name) is \(age) years old and plays for the \(team) in \(league)"
    }
}
