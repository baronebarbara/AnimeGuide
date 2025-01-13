import Foundation

public enum RequestMethod: String {
    case get
}

public enum RequestEncoding {
    case query
}

public protocol RequestProtocol {
    var path: String { get }
    var headers: [String: String] { get }
    var method: RequestMethod { get }
    var encoding: RequestEncoding { get }
}
