import Foundation

struct AnimeListRequest: RequestProtocol {
    let page: Int
    
    var path: String {  "top/anime?page=\(page)" }
    var body: Encodable? {  nil }
    var headers: [String: String] { ["Content-Type": "application/json"] }
    var method: RequestMethod { .get }
    var encoding: RequestEncoding { .query }
}
