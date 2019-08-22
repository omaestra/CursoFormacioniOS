//
//  CharactersPresenter.swift
//  RickAndMortyMVP
//
//  Created by omaestra on 22/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

protocol CharacterViewDelegate: NSObjectProtocol {
    func displayCharacters(pagedData: PagedData<Character>)
}

class CharactersPresenter {
    private let characterService: CharacterService
    weak private var delegate: CharacterViewDelegate?

    init(service: CharacterService) {
        self.characterService = service
    }
    
    func setViewDelegate(delegate: CharacterViewDelegate?) {
        self.delegate = delegate
    }
    
    func loadCharacters() {
        characterService.loadCharacters { [weak self] (pagedData) in
            if let pagedData = pagedData {
                self?.delegate?.displayCharacters(pagedData: pagedData)
            }
        }
    }
}
