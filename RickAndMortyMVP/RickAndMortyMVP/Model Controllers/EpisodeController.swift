//
//  EpisodeController.swift
//  RickAndMorty
//
//  Created by omaestra on 21/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

class EpisodeController {
    func loadEpisodes(url: String? = nil, completion: @escaping (_ pagedData: PagedData<Episode>?) -> Void) {
        
        var baseURL = URL(string: "https://rickandmortyapi.com/api/episode/")!
        if let nextUrl = url, nextUrl != "" {
            baseURL = URL(string: nextUrl)!
        }
        
        let jsonDecoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let data = data,
                let pagedData = try? jsonDecoder.decode(PagedData<Episode>.self, from: data) {
                completion(pagedData)
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    func loadMultipleEpisodes(withIds episodesIdArray: [String], completion: @escaping (_ episodes: [Episode]?) -> Void) {
        var baseURL = URL(string: "https://rickandmortyapi.com/api/episode/")!
        
        baseURL.appendPathComponent(episodesIdArray.joined(separator: ","))
        
        let jsonDecoder = JSONDecoder()
        
        if episodesIdArray.count > 1 {
            URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
                if let data = data,
                    let episodes = try? jsonDecoder.decode([Episode].self, from: data) {
                    completion(episodes)
                } else {
                    completion(nil)
                }
                }.resume()
        } else {
            URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
                if let data = data,
                    let episode = try? jsonDecoder.decode(Episode.self, from: data) {
                    completion([episode])
                } else {
                    completion(nil)
                }
                }.resume()
        }
        
    }
    
    func loadEpisode(byId id: String, completion: @escaping (_ episode: Episode?) -> Void) {
        var baseURL = URL(string: "https://rickandmortyapi.com/api/episode/")!
        
        baseURL.appendPathComponent(id)
        
        let jsonDecoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let data = data,
                let episode = try? jsonDecoder.decode(Episode.self, from: data) {
                completion(episode)
            } else {
                completion(nil)
            }
            }.resume()
    }
}
