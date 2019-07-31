import UIKit


struct Note: Codable {
    let title: String
    let text: String
    let timestamp: Date
}

let newNote = Note(title: "Grocery Run", text: "Pick up mayonnaise, mustard, lettuce, tomato and pickles", timestamp: Date())

let propertyListEncoder = JSONEncoder()
if let encodedNote = try? propertyListEncoder.encode(newNote) {
    print(String(data: encodedNote, encoding: .utf8))
    
    let propertyListDecoder = PropertyListDecoder()
    if let decodedNote = try? propertyListDecoder.decode(Note.self, from: encodedNote) {
        print(decodedNote)
    }
}

