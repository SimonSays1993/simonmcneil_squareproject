import Foundation

class ApiPreviewClient: APIService {
    var fetchSuccessful: Bool = true
    
    func request<T>(_ resource: Resource<T>) async throws -> T {
        do {
            return try stubData(for: resource.endPoint.urlString)
        } catch {
            throw error
        }
    }
    
    private func stubData<T: Decodable>(for fileName: String) throws -> T {
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
            return try DecodeParser(decoder: jsonDecoder).decodeData(data: data)
        } catch {
            fetchSuccessful = false
            throw APIError.failedDecoding
        }
    }
    
    func downloadImage(with url: URL) -> Data? {
        return nil
    }
}
