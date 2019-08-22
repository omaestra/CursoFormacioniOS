//
//  EpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Usuario on 14/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell, IdentifiableCell {

    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeAirDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
