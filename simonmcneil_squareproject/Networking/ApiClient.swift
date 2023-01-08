import Foundation

struct ApiClient: APIService {
    
    @MainActor
    func request<T: Decodable>(_ resource: Resource<T>, endpoint: APIEndpoint) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(from: resource.createUrl(url: endpoint))
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
                        
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try! DecodeParser(decoder: jsonDecoder).decodeData(data: data)
        } catch let error {
            throw error
        }
    }
}
