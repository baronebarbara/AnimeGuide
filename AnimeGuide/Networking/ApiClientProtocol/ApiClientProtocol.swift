import Foundation

protocol ApiClientProtocol {
    func fetch<T: Decodable>(request: RequestProtocol) async throws -> T
}
