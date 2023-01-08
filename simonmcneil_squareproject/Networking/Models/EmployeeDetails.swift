import Foundation

struct EmployeeDetails: Hashable, Decodable {
    let uuid: String
    let fullName: String
    let phoneNumber: String
    let emailAddress: String
    let biography: String
    let photoUrlSmall: URL
    let photoUrlLarge: URL
    let team: String
    let employeeType: EmployeeType
    
    enum EmployeeType: String, Decodable {
        case contractor = "CONTRACTOR"
        case fullTime = "FULL_TIME"
        case partTime = "PART_TIME"
    }
}
