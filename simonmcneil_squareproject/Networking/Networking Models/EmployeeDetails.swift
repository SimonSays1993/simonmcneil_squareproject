import Foundation

struct EmployeeDetails: Decodable {
    let uuid: String
    let fullName: String
    let phoneNumber: String?
    let emailAddress: String
    let biography: String?
    let photoUrlSmall: URL?
    let photoUrlLarge: URL?
    let team: String
    let employeeType: EmployedStatus
    
    enum EmployedStatus: String, Decodable {
        case contractor = "CONTRACTOR"
        case fullTime = "FULL_TIME"
        case partTime = "PART_TIME"
    }
}

extension EmployeeDetails.EmployedStatus {
    var employedStatusDescription: String {
        switch self {
        case .contractor:
            return "Contractor"
        case .fullTime:
            return "Full Time"
        case .partTime:
            return "Part Time"
        }
    }
    
    var sectionOrder: Int {
        switch self {
        case .fullTime:
            return 0
        case .partTime:
            return 1
        case .contractor:
            return 2
        }
    }
}
