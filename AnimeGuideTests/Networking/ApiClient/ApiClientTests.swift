import XCTest

@testable import AnimeGuide

final class ApiClientTests: XCTestCase {
    private var mockSession: MockURLSession = MockURLSession()
    private var apiClient: ApiClient?
    
    override func setUp() {
        super.setUp()
        apiClient = ApiClient(urlSession: mockSession)
    }
    
    override func tearDown() {
        apiClient = nil
        super.tearDown()
    }
    
    func test_Fetch_WhenRequestSucceeds_ShouldReturnData() async throws {
        guard let apiClient = apiClient else {
            XCTFail("Dependencies not initialized")
            return
        }
        
        mockSession.data = """
        {
            "id": 1,
            "name": "Test Item"
        }
        """.data(using: .utf8)
        
        let request = MockRequest(path: "valid-endpoint")
        
        let result: TestObject = try await apiClient.fetch(request: request)
        
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "Test Item")
    }
    
    func test_Fetch_WhenURLIsInvalid_ShouldThrowNotFoundError() async throws {
        guard let apiClient = apiClient else {
            XCTFail("Dependencies not initialized")
            return
        }
        
        mockSession.statusCode = 404
        
        let request = MockRequest(path: "invalid-url")
        
        do {
            let _: TestObject = try await apiClient.fetch(request: request)
            XCTFail("Expected an error but got a result.")
        } catch let error as ApiError {
            XCTAssertEqual(error, .notFound)
        }
    }
    
    func test_Fetch_WhenResponseIsInvalid_ShouldThrowInvalidDataError() async throws {
        guard let apiClient = apiClient else {
            XCTFail("Dependencies not initialized")
            return
        }
        
        mockSession.data = """
        {
            "unexpected_key": "Unexpected Value"
        }
        """.data(using: .utf8)
        
        let request = MockRequest(path: "valid-endpoint")
        
        do {
            let _: TestObject = try await apiClient.fetch(request: request)
            XCTFail("Expected an error but got a result.")
        } catch let error as ApiError {
            XCTAssertEqual(error, ApiError.invalidData)
        }
    }
}

final class MockURLSession: URLSessionProtocol {
    var data: Data?
    var error: Error?
    var statusCode: Int = 200
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        guard let url = request.url, url.scheme != nil else {
            throw URLError(.unsupportedURL)
        }
        
        if let error = error {
            throw error
        }
        
        guard let data = data else {
            throw URLError(.badServerResponse)
        }
        
        guard let response = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        ) else {
            throw URLError(.badServerResponse)
        }
        
        if !(200...299).contains(statusCode) {
            throw URLError(.badServerResponse)
        }
        
        return (data, response)
    }
}

struct MockRequest: RequestProtocol {
    var headers: [String: String] = [:]
    var method: RequestMethod { .get }
    var encoding: RequestEncoding { .query }
    var path: String
}

struct TestObject: Decodable {
    let id: Int
    let name: String
}
