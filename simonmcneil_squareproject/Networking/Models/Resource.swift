import Foundation

struct Resource<T: Decodable> {
    var httpMethod: HTTPMethod = .get
    var endPoint: EndpointConfigurable
    
    func createUrl(url: EndpointConfigurable) throws -> URL {
        guard let baseUrl = URL(string: url.urlString) else {
            throw APIError.incorrectBaseUrl
        }
        
        // Create URL Components
        let components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
        
        guard let url = components?.url else {
            throw APIError.unableToCreateUrl
        }
        
        return url
    }
}
