//
//  ToDoTableViewCell.swift
//  List
//
//  Created by omaestra on 04/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

protocol ToDoCellDelegate {
    func checkMarkTapped(_ sender: ToDoTableViewCell)
}

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: ToDoCellDelegate?
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        delegate?.checkMarkTapped(self)
    }


}
