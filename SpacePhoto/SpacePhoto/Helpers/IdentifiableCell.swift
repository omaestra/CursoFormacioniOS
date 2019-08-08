//
//  IdentifiableCell.swift
//  SpacePhoto
//
//  Created by omaestra on 08/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

protocol IdentifiableCell {
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

extension IdentifiableCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}
