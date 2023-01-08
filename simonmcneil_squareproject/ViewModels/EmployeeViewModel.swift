import SwiftUI
import OrderedCollections

final class EmployeeViewModel: ObservableObject {
    @Published var employeeSections: [OrderedDictionary<String, [EmployeeSections]>.Element] = []
    @Published var errorMessage: String = ""
    
    private let apiService: APIService
    private let resource: Resource<Employees>

    init(apiService: APIService, resource: Resource<Employees>) {
        self.apiService = apiService
        self.resource = resource
    }
    
    @MainActor
    func fetchEmployees() async {
        do {
            let response = try await apiService.request(resource)
            createEmployeeSections(with: response.employees)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    private func createEmployeeSections(with employees: [EmployeeDetails]) {
        let sortedEmployeesByName = employees
            .map { EmployeeSections(employeeType: $0.employeeType.employedStatusDescription, employee: $0 ) }
            .sortedByKeyPath(by: \.fullName)
        
        employeeSections = OrderedDictionary(grouping: sortedEmployeesByName) { $0.employeeType }
            .sortedByKeyPath(by: \.key)        
    }
}
