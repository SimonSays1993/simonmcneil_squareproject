import Foundation

struct ApiPreviewClient: APIService {
    func request<T>(_ resource: Resource<T>, endpoint: APIEndpoint) async throws -> T {
        return stubData(for: InfoPlistParser.shared.configUrl(key: endpoint.urlString))
    }
    
    func stubData<T: Decodable>(for fileName: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("Coundn't find \(fileName) in main bundle")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(fileName) from main bundle:\n\(error)")
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(fileName) as \(T.self):\n\(error)")
        }
    }
    
}
