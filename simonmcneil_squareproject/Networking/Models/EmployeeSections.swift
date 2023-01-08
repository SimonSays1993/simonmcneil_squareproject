import Foundation

@dynamicMemberLookup
struct EmployeeSections: Identifiable {
    let id: UUID = UUID()
    let employeeType: String
    let employee: EmployeeDetails
    
    subscript<T>(dynamicMember keyPath: KeyPath<EmployeeDetails, T>) -> T {
        employee[keyPath: keyPath]
    }
}
