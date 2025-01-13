import Foundation

protocol AnimeListViewModelProtocol {
    var onAnimeListUpdate: (([AnimeListViewCellViewModel]) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    func fetchAnimeList()
}

final class AnimeListViewModel: @preconcurrency AnimeListViewModelProtocol {
    var onAnimeListUpdate: (([AnimeListViewCellViewModel]) -> Void)?
    var onError: ((String) -> Void)?
    
    private let animeService: AnimeListServiceProtocol
    
    private var currentPage: Int = 1,
                hasNextPage: Bool = true,
                isFetching: Bool = false
    
    private var allAnimeList: [AnimeListViewCellViewModel] = []
    
    init(animeService: AnimeListServiceProtocol = AnimeListServiceFactory.build()) {
        self.animeService = animeService
    }
    
    @MainActor
    func fetchAnimeList() {
        guard !isFetching && hasNextPage else { return }
        isFetching = true
        
        Task {
            defer { isFetching = false }
            do {
                let response = try await fetchAnimeData(page: currentPage)
                updatePagination(from: response.pagination)
                let newAnimes = mapAnimeResponseToViewModels(response.data)
                updateAnimeList(with: newAnimes)
            } catch {
                handleFetchError(error)
            }
        }
    }
    
    // MARK: - Private Methods
    private func fetchAnimeData(page: Int) async throws -> AnimeResponse {
        return try await animeService.fetchList(page: page)
    }
    
    private func updatePagination(from pagination: AnimeResponse.Pagination?) {
        if let pagination = pagination {
            currentPage = pagination.currentPage ?? 0
            hasNextPage = pagination.hasNextPage ?? false
        } else {
            hasNextPage = false
        }
    }
    
    private func mapAnimeResponseToViewModels(_ data: [AnimeResponse.Anime]) -> [AnimeListViewCellViewModel] {
        return data.map { anime in
            AnimeListViewCellViewModel(
                name: anime.title ?? "",
                genres: anime.genres.compactMap { $0.name },
                year: anime.aired.from.flatMap { String($0.prefix(4)) } ?? "",
                score: String(format: "%.1f", anime.score ?? 0.0),
                imageUrl: URL(string: anime.images?.jpg?.imageUrl ?? "")
            )
        }
    }
    
    private func updateAnimeList(with newAnimes: [AnimeListViewCellViewModel]) {
        allAnimeList.append(contentsOf: newAnimes)
        onAnimeListUpdate?(allAnimeList)
    }
    
    private func handleFetchError(_ error: Error) {
        onError?("Failed to fetch anime list: \(error.localizedDescription)")
    }
}
