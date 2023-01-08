import Foundation

enum APIEndpoint: String, EndpointConfigurable {
    case employeeDetails
    case employeeEmpty
    case emplpoyeeError
    
    var urlString: String {
        switch self {
        case .employeeDetails:
            return InfoPlistParser.shared.configUrl(key: APIEndpoint.employeeDetails.rawValue)
        case .employeeEmpty:
            return InfoPlistParser.shared.configUrl(key: APIEndpoint.employeeEmpty.rawValue)
        case .emplpoyeeError:
            return InfoPlistParser.shared.configUrl(key: APIEndpoint.emplpoyeeError.rawValue)
        }
    }
}
