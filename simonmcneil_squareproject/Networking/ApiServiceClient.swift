import Foundation
import UIKit

struct ApiServiceClient: APIService {

    func request<T: Decodable>(_ resource: Resource<T>) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(from: resource.createUrl(url: resource.endPoint))
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
                        
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                return try DecodeParser(decoder: jsonDecoder).decodeData(data: data)
            } catch {
                throw APIError.failedDecoding
            }
        } catch let error {
            throw error
        }
    }
}
