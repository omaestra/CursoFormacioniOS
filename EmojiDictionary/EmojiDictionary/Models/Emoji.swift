//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by omaestra on 31/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import Foundation

struct Emoji: Codable {
    var symbol: Character
    var name: String
    var description: String
    var usage: String
    
    private enum CodingKeys: String, CodingKey {
        case symbol, description, usage
        case name = "Nombre Emoji"
    }
    
    static var ArchiveURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static var path = Emoji.ArchiveURL.appendingPathComponent("emojis").appendingPathExtension("plist")
    
    init(symbol: Character, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let symbolString = try container.decode(String.self, forKey: .symbol)
        symbol = symbolString.first!
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        usage = try container.decode(String.self, forKey: .usage)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(String(symbol), forKey: .symbol)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(usage, forKey: .usage)
        
    }
    
    static func saveEmojisToFile(_ emojis: [Emoji]) {
        let propertyListEncoder = PropertyListEncoder()
        
        do {
            let encodedEmojis = try propertyListEncoder.encode(emojis)
            
            try encodedEmojis.write(to: Emoji.path, options: .noFileProtection)
        } catch let error {
            print("[ERROR]: \(error.localizedDescription)")
        }
        
    }
    
    static func loadEmojisFromFile() -> [Emoji]? {
        let properyListDecoder = PropertyListDecoder()
        if let retrievedData = try? Data(contentsOf: Emoji.path), let decodedEmojis = try? properyListDecoder.decode([Emoji].self, from: retrievedData) {
            
            return decodedEmojis
        } else {
            return nil
        }
    }
    
    static func loadLocalEmojis() -> [Emoji] {
        let emojis = [
            Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),

            Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
            Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
            Emoji(symbol: "👮", name: "Police Officer", description: "A police officer wearing a blue cap with a gold badge. He is smiling, and eager to help.", usage: "person of authority"),
            Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "Something slow"),
            Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
            Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
            Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
            Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
            Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
            Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
            Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
            Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black and white checkered flag.", usage: "completion")
        ]

        return emojis
    }
}
