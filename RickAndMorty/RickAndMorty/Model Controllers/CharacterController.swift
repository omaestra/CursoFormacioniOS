//
//  CharacterController.swift
//  RickAndMorty
//
//  Created by Usuario on 14/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

class CharacterController {
    
    func loadCharacters(url: String? = nil, completion: @escaping (_ characters: PagedData<Character>?) -> Void) {
        
        var baseURL = URL(string: "https://rickandmortyapi.com/api/character/")!
        
//        var url = baseURL
        
        if let nextUrl = url, nextUrl != "" {
            baseURL = URL(string: nextUrl)!
        }
        
        let jsonDecoder = JSONDecoder()
        
        URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let data = data,
                let pagedData = try? jsonDecoder.decode(PagedData<Character>.self, from: data) {
                completion(pagedData)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
