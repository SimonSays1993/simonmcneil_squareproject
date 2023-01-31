import Foundation

struct EmployeeDetails: Codable {
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
    }
    
    enum CodingKeys: CodingKey {
        case uuid
        case fullName
        case phoneNumber
        case emailAddress
        case biography
        case photoUrlSmall
        case photoUrlLarge
        case team
        case employeeType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
        self.emailAddress = try container.decode(String.self, forKey: .emailAddress)
        self.biography = try container.decodeIfPresent(String.self, forKey: .biography)
        self.photoUrlSmall = try container.decodeIfPresent(URL.self, forKey: .photoUrlSmall)
        self.photoUrlLarge = try container.decodeIfPresent(URL.self, forKey: .photoUrlLarge)
        self.team = try container.decode(String.self, forKey: .team)
        self.employeeType = try container.decode(EmployeeDetails.EmployedStatus.self, forKey: .employeeType)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(fullName, forKey: .fullName)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(emailAddress, forKey: .emailAddress)
        try container.encode(biography, forKey: .biography)
        try container.encode(photoUrlSmall, forKey: .photoUrlSmall)
        try container.encode(photoUrlLarge, forKey: .photoUrlLarge)
        try container.encode(team, forKey: .team)
        try container.encode(employeeType.rawValue, forKey: .employeeType)
    }
}
