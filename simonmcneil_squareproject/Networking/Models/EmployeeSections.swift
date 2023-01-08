import Foundation

@dynamicMemberLookup
struct EmployeeSections {
    let employeeType: String
    let employee: EmployeeDetails
    
    subscript<T>(dynamicMember keyPath: KeyPath<EmployeeDetails, T>) -> T {
        employee[keyPath: keyPath]
    }
}
