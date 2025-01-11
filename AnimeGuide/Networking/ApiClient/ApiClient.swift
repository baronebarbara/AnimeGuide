import Foundation

enum ApiError: Error {
    case notFound,
         business,
         invalidData
}

struct ApiClientFactory {
    public static func build() -> ApiClientProtocol {
        ApiClient()
    }
}

private final class ApiClient: ApiClientProtocol {
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetch<T: Decodable>(request: RequestProtocol) async throws -> T {
        guard let url = URL(string: request.path) else {
            throw ApiError.notFound
        }
        
        let (data, response) = try await urlSession.data(from: url, delegate: nil)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        if let resultObject = try? decoder.decode(T.self, from: data) {
            return resultObject
        } else {
            throw ApiError.invalidData
        }
    }
}
