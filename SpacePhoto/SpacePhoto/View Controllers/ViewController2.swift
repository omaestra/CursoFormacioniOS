//
//  ViewController2.swift
//  SpacePhoto
//
//  Created by omaestra on 07/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                URLSession.shared.dataTask(with: photoInfo.url, completionHandler: { (data, response, error) in
                    if let data = data,
                        let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.title = photoInfo.title
                            self.textField.text = photoInfo.description
                            self.imageView.image = image
                        }
                    }
                }).resume()
            }
        }
    }
    
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        let queries: [String: String] = [
            "api_key": "vgmntRvK9bQ1SNnn1n6z9ieib2FcdlHhSsOqmfTf",
            "count": "5"
        ]
        
        let url = baseURL.withQueries(queries)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let photoInfo = try? jsonDecoder.decode([PhotoInfo].self, from: data) {
                
                completion(photoInfo.first)
            } else {
                print("Could not decode")
                completion(nil)
            }
        }
        
        task.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
