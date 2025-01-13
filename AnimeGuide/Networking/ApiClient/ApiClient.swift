import Foundation

enum ApiError: Error, Equatable {
    case notFound,
         business,
         invalidData,
         decodingError(String)
}

struct ApiClientFactory {
    public static func build() -> ApiClientProtocol {
        ApiClient()
    }
}

final class ApiClient: ApiClientProtocol {
    private let urlSession: URLSessionProtocol
    private let baseURL: String = "https://api.jikan.moe/v4/"
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetch<T: Decodable>(request: RequestProtocol) async throws -> T {
        guard let url = URL(string: baseURL + request.path) else {
            throw ApiError.notFound
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        do {
            let (data, response) = try await urlSession.data(for: urlRequest, delegate: nil)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw ApiError.business
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch let urlError as URLError {
            if urlError.code == .unsupportedURL || urlError.code == .badServerResponse {
                throw ApiError.notFound
            }
            throw ApiError.business
        } catch {
            throw ApiError.invalidData
        }
    }
}
