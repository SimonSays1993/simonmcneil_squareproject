import Foundation
@testable import simonmcneil_squareproject

enum MockApiEndPoints: String, EndpointConfigurable {
    case employeeDetails
    case employeeEmpty
    case emplpoyeeError
    case decodingError
    
    // Just need to pass the file name for mock, don't need actual url
    var urlString: String {
        switch self {
        case .employeeDetails:
            return "employee"
        case .employeeEmpty:
            return "employeeEmptyResponse"
        case .emplpoyeeError:
            return "employeeErrorResponse"
        case .decodingError:
            return "decodingError"
        }
    }
}
