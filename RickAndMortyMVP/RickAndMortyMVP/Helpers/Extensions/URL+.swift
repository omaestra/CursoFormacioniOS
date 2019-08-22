//
//  URL+.swift
//  RickAndMorty
//
//  Created by Usuario on 14/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map({ URLQueryItem(name: $0.key, value: $0.value) })
        
        return components?.url
    }
}
