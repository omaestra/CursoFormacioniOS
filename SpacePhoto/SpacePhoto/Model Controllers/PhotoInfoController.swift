//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by omaestra on 07/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

class PhotoInfoController {
    func fetchPhotoInfo(queries: [String: String], completion: @escaping (PhotoInfo?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        let url = baseURL.withQueries(queries)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
                let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfo)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchMultiplePhotosInfo(queries: [String: String], completion: @escaping ([PhotoInfo]?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        var query: [String: String] = queries
        query["count"] = "50"
        
        let url = baseURL.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
                let string = String(data: data, encoding: .utf8) {
                print(string)
            }
            
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
