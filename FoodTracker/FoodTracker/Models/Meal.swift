//
//  Meal.swift
//  FoodTracker
//
//  Created by omaestra on 28/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Meal: Codable {
    
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    
    private enum CodingKeys: String, CodingKey {
        case name, photo, rating
    }
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0  {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
    
    //MARK: NSCoding
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        if let photo = photo, let data = photo.pngData() {
            try container.encode(data, forKey: .photo)
        }
        try container.encode(rating, forKey: .rating)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decode(Int.self, forKey: .rating)
        
        if let data = try container.decodeIfPresent(Data.self, forKey: .photo) {
            photo = UIImage(data: data)
        }
    }
}
