import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap({ URLQueryItem(name: $0.key, value: $0.value )})
        
        return components?.url
    }
}

let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!

let queries: [String: String] = [
    "api_key": "DEMO_KEY",
    "count": "2"
]

let url = baseURL.withQueries(queries)!

let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let data = data,
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
//        let result = String(data: data, encoding: .utf8) {
        print(json)
    }
}

task.resume()
