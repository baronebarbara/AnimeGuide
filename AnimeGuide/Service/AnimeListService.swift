import Foundation

protocol AnimeListServiceProtocol {
    func fetchList()
}

enum AnimeListServiceFactory {
    static func build() -> AnimeListServiceProtocol {
        AnimeListService()
    }
}

private final class AnimeListService: AnimeListServiceProtocol {
    func fetchList() {}
}
