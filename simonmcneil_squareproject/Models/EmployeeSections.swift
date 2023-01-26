import Foundation

@dynamicMemberLookup
struct EmployeeSections: Identifiable {
    let id: UUID = UUID()
    let position: Int
    let employeePosition: String
    let employee: EmployeeDetails
    
    subscript<T>(dynamicMember keyPath: KeyPath<EmployeeDetails, T>) -> T {
        employee[keyPath: keyPath]
    }
}
