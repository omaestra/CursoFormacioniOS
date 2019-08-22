//
//  LocationsController.swift
//  RickAndMorty
//
//  Created by omaestra on 16/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

class LocationsController {
    func loadLocations(url: String? = nil, completion: @escaping (_ pagedData: PagedData<Location>?) -> Void) {
        
        var baseURL = URL(string: "https://rickandmortyapi.com/api/location/")!
        if let nextUrl = url, nextUrl != "" {
            baseURL = URL(string: nextUrl)!
        }
        
        let jsonDecoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let data = data,
                let pagedData = try? jsonDecoder.decode(PagedData<Location>.self, from: data) {
                completion(pagedData)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    func loadMultipleLocations(withIds locationsIdArray: [String], completion: @escaping (_ locations: [Location]?) -> Void) {
        var baseURL = URL(string: "https://rickandmortyapi.com/api/location/")!
        
        baseURL.appendPathComponent(locationsIdArray.joined(separator: ","))
        
        let jsonDecoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let data = data,
                let locations = try? jsonDecoder.decode([Location].self, from: data) {
                completion(locations)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    func loadLocation(byId id: String, completion: @escaping (_ location: Location?) -> Void) {
        loadMultipleLocations(withIds: [id]) { (locations) in
            completion(locations?.first)
        }
    }
}
