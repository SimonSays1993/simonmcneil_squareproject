import Foundation

protocol APIService {
    func request<T: Decodable>(_ resource: Resource<T>, endpoint: APIEndpoint) async throws -> T
}
