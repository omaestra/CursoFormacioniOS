//
//  EpisodeTableViewCell.swift
//  RickAndMortyMVP
//
//  Created by omaestra on 26/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell, IdentifiableCell {

    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
