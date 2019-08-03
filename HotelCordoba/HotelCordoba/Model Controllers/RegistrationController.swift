//
//  RegistrationController.swift
//  HotelCordoba
//
//  Created by omaestra on 02/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

class RegistrationController {
    
    static private(set) var archiveURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static private(set) var filePath = RegistrationController.archiveURL.appendingPathComponent("registrations").appendingPathExtension("plist")
    
    
    func loadRegistrationsFromFile() -> [Registration]? {
        let propertyListDecoder = PropertyListDecoder()
        
        if let data = try? Data(contentsOf: RegistrationController.filePath),
            let registrations = try? propertyListDecoder.decode([Registration].self, from: data) {
            return registrations
        }
        
        return nil
    }
    
    func saveRegistrationsToFile(_ registrations: [Registration]) {
        let propertyListEncoder = PropertyListEncoder()
        
        do {
            if let encodedData = try? propertyListEncoder.encode(registrations) {
                try encodedData.write(to: RegistrationController.filePath, options: .noFileProtection)
            }
        } catch (let error) {
            debugPrint("[ERROR]: Couldn't save registrations into file. \(error.localizedDescription)")
        }
    }
}
