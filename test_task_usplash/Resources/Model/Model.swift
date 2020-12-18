
import Foundation



struct Root: Codable {
    let results: [Result]
}
struct Result: Codable {
    let alt_description: String?
    var urls: Urls
}

struct Urls: Codable {
    var thumb: URL?
}
