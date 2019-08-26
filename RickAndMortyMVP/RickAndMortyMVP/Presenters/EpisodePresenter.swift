//
//  EpisodePresenter.swift
//  RickAndMortyMVP
//
//  Created by omaestra on 26/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

protocol EpisodeViewDelegate: class {
    func displayPagedEpisodes(with pagedData: PagedData<Episode>)
    func displayEpisodes(_ episodes: [Episode])
}

class EpisodePresenter {
    private let service: EpisodeService
    private weak var delegate: EpisodeViewDelegate?
    
    init(service: EpisodeService) {
        self.service = service
    }
    
    func setViewDelegate(delegate: EpisodeViewDelegate) {
        self.delegate = delegate
    }
    
    func loadEpisodes() {
        self.service.loadEpisodes { (pagedData) in
            if let pagedData = pagedData {
                self.delegate?.displayPagedEpisodes(with: pagedData)
            }
        }
    }
    
    func loadMultipleEpisodes(idsArray: [String]) {
        self.service.loadMultipleEpisodes(withIds: idsArray) { (episodes) in
            if let episodes = episodes {
                self.delegate?.displayEpisodes(episodes)
            }
        }
    }
}
