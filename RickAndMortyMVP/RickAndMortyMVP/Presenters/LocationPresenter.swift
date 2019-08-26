//
//  LocationPresenter.swift
//  RickAndMortyMVP
//
//  Created by omaestra on 26/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

protocol LocationViewDelegate: class {
    func displayPagedLocations(with pagedData: PagedData<Location>)
    func displayLocations(_ locations: [Location])
}

class LocationPresenter {
    var service: LocationService
    var delegate: LocationViewDelegate?
    
    init(service: LocationService) {
        self.service = service
    }
    
    func setViewDelegate(delegate: LocationViewDelegate) {
        self.delegate = delegate
    }
    
    func loadLocations() {
        service.loadLocations { (pagedData) in
            if let pagedData = pagedData {
                self.delegate?.displayPagedLocations(with: pagedData)
            }
        }
    }
    
    func loadMultipleLocations(idsArray: [String]) {
        service.loadMultipleLocations(withIds: idsArray) { (locations) in
            if let locations = locations {
                self.delegate?.displayLocations(locations)
            }
        }
    }
}
