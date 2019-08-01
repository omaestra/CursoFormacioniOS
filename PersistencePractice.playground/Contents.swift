import UIKit


struct Note: Codable {
    let title: String
    let text: String
    let timestamp: Date
    
    private enum CodingKeys: String, CodingKey {
        case title, text
        case timestamp = "time_stamp"
    }
    
    init(title: String, text: String, timestamp: Date) {
        self.title = title
        self.text = text
        self.timestamp = timestamp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.text = try container.decode(String.self, forKey: .text)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
    }
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

func fetchPhotoInfo(completion: @escaping (Note) -> Void) {
    let url = URL(string: "https://api.example.com/notes")
    
    let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
            let note = try? jsonDecoder.decode(Note.self, from: data) {
            completion(note)
        }
    }
    
    task.resume()
}

