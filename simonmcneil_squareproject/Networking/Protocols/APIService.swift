import Foundation

protocol APIService {
    func request<T: Decodable>(_ resource: Resource<T>) async throws -> T
}
