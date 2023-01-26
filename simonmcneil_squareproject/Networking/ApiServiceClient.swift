import Foundation
import UIKit
import SwiftUI

struct ApiServiceClient: APIService {
    var isLoaded: Bool = false
    
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

/*
 If you instantiate a session object, you can use the .main queue as a target and avoid the Dispatch calls. But that also brings the JSON decoding to the main thread. For large amounts of data, it’s better to keep it in the background.
 */
