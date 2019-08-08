//
//  PhotoInfoTableViewCell.swift
//  SpacePhoto
//
//  Created by omaestra on 07/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit


class PhotoInfoTableViewCell: UITableViewCell, IdentifiableCell {

    @IBOutlet weak var photoInfoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoInfoImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for photoInfo: PhotoInfo) {
        self.titleLabel.text = photoInfo.title
        self.descriptionLabel.text = photoInfo.description
        self.photoInfoImageView.loadImage(fromURL: photoInfo.url.absoluteString)
    }
    
    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        likeButton.transform = CGAffineTransform.identity
    }
    
    @IBAction func buttonTouchDown(_ sender: Any) {
        likeButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        UIView.animate(withDuration: 3.3) {
            self.likeButton.transform = CGAffineTransform.identity
        }
        
    }
    
}
