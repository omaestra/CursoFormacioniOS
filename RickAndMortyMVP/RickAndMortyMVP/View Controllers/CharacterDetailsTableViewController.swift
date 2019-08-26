//
//  CharacterDetailsTableViewController.swift
//  RickAndMorty
//
//  Created by omaestra on 16/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class CharacterDetailsTableViewController: UITableViewController {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var lastLocationLabel: UILabel!
    
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updatedUI()
    }
    
    func updatedUI() {
        characterImageView.loadImage(fromURL: character.image)
        nameLabel.text = character.name
        speciesLabel.text = "\(character.species)"
        
        if character.type != "" {
            speciesLabel.text?.append(" - \(character.type)")
        }
        
        genderLabel.text = character.gender
        statusLabel.text = character.status.rawValue
        statusLabel.textColor = character.status.color
        originLabel.text = character.origin["name"]
        lastLocationLabel.text = character.location["name"]
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == [0, 0] {
            return UITableViewAutomaticDimension
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCharacterEpisodes" {
            let destination = (segue.destination as! UINavigationController).topViewController as! EpisodesTableViewController
            destination.episodesIds = character.episode.map({ ($0 as NSString).lastPathComponent })
        }
    }

}
