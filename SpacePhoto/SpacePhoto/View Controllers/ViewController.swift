//
//  ViewController.swift
//  SpacePhoto
//
//  Created by omaestra on 07/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    let photoInfoController = PhotoInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        
//        let wantHD = true
//        
//        var query: [String: String] = [
//            "api_key": "vgmntRvK9bQ1SNnn1n6z9ieib2FcdlHhSsOqmfTf",
//            
//        ]
//        
//        if wantHD {
//            query["hd"] = "true"
//        }
//        photoInfoController.fetchPhotosInfo(queries: query) { (photoInfo) in
//            guard let photoInfo = photoInfo else { return }
//            
//            self.updateUI(with: photoInfo)
//        }
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        let task = URLSession.shared.dataTask(with: photoInfo.url) { (data, response, error) in
            guard let data = data,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.title = photoInfo.title
                self.descriptionTextView.text = photoInfo.description
                self.copyrightLabel.text = photoInfo.copyright
                self.imageView.image = image
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        task.resume()
    }


}

