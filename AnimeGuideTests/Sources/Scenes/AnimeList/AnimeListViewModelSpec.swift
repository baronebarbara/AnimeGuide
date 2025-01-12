import XCTest

@testable import AnimeGuide

final class AnimeListViewModelSpec: XCTestCase {
    private var viewModel: AnimeListViewModelProtocol?
    private var serviceSpy = AnimeListServiceSpy()
    
    override func setUp() {
        super.setUp()
        viewModel = AnimeListViewModel(animeService: serviceSpy)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    func test_FetchAnimeList_WhenServiceSucceeds_ShouldUpdateAnimeList() async {
        serviceSpy.isSuccess = true
        let expectation = XCTestExpectation(description: "onAnimeListUpdate called")
        viewModel?.onAnimeListUpdate = { animeList in
            XCTAssertEqual(animeList.count, 1)
            XCTAssertEqual(animeList.first?.name, "Naruto")
            XCTAssertEqual(animeList.first?.genres, ["shounen"])
            XCTAssertEqual(animeList.first?.score, "10.0")
            expectation.fulfill()
        }
        
        viewModel?.fetchAnimeList()
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func test_FetchAnimeList_WhenServiceFails_ShouldTriggerOnError() async {
        serviceSpy.isSuccess = false
        let expectation = XCTestExpectation(description: "onError called")
        viewModel?.onError = { errorMessage in
            XCTAssertTrue(errorMessage.contains("Failed to fetch anime list"))
            expectation.fulfill()
        }
        
        viewModel?.fetchAnimeList()
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
}

private final class AnimeListServiceSpy: AnimeListServiceProtocol {
    var isSuccess: Bool = false
    
    func fetchList(page: Int) async throws -> AnimeResponse {
        if isSuccess {
            return AnimeResponse(pagination: .init(hasNextPage: true,
                                                   currentPage: 0),
                                 data: [.init(malId: 1234,
                                              title: "Naruto",
                                              score: 10.0,
                                              synopsis: "Um anime muito bom de um rapaz que sonha em ser hokage",
                                              images: .init(jpg: .init(imageUrl: "naruto.jpg")),
                                              genres: [.init(name: "shounen")],
                                              aired: .init(from: "2002-10-03"))])
        } else {
            throw NSError(domain: "AnimeListService",
                          code: -1,
                          userInfo: [NSLocalizedDescriptionKey: "Service failure"])
        }
    }
}
