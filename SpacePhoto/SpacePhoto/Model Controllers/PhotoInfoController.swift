//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by omaestra on 07/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

class PhotoInfoController {
    func fetchPhotosInfo(queries: [String: String], completion: @escaping ([PhotoInfo]?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        
        let url = baseURL.withQueries(queries)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
                let photoInfo = try? jsonDecoder.decode([PhotoInfo].self, from: data) {
                completion(photoInfo)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
