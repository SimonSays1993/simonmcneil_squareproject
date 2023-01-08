import Foundation

enum APIEndpoint: String, EndpointConfigurable {
    case employeeDetails
    case employeeEmpty
    case employeeError
    
    var urlString: String {
        switch self {
        case .employeeDetails:
            return InfoPlistParser.shared.configUrl(key: APIEndpoint.employeeDetails.rawValue)
        case .employeeEmpty:
            return InfoPlistParser.shared.configUrl(key: APIEndpoint.employeeEmpty.rawValue)
        case .employeeError:
            return InfoPlistParser.shared.configUrl(key: APIEndpoint.employeeError.rawValue)
        }
    }
}
