import Foundation

protocol AnimeListServiceProtocol {
    func fetchList(page: Int) async throws -> AnimeResponse
}

enum AnimeListServiceFactory {
    static func build() -> AnimeListServiceProtocol {
        AnimeListService()
    }
}

private final class AnimeListService: AnimeListServiceProtocol {
    private let apiClient: ApiClientProtocol
    
    init(apiClient: ApiClientProtocol = ApiClientFactory.build()) {
        self.apiClient = apiClient
    }
    
    func fetchList(page: Int) async throws -> AnimeResponse {
        let request = AnimeListRequest(page: page)
        return try await apiClient.fetch(request: request)
    }
}
