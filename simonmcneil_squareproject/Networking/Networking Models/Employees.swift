import Foundation

struct Employees: Codable {
    let employees: [EmployeeDetails]
    
    enum CodingKeys: CodingKey {
        case employees
    }
    
    func encode(to encoder: Encoder) throws {
        var container  = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(employees, forKey: .employees)
    }
}
