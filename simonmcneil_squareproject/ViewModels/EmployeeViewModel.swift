import SwiftUI
import OrderedCollections

@MainActor
final class EmployeeViewModel: ObservableObject {
    @Published var employeeSections: OrderedDictionary<String, [EmployeeSections]> = [:]
    @Published var errorMessage: String = ""
    
    private let apiService: APIService
    private let resource: Resource<Employees>

    init(apiService: APIService, resource: Resource<Employees> = Resource<Employees>()) {
        self.apiService = apiService
        self.resource = resource
    }
    
    func fetchEpisodes() async {
        do {
            let response = try await apiService.request(resource, endpoint: .employeeDetails)
            createEmployeeSections(with: response.employees)
        } catch {
            errorMessage = error.localizedDescription
            self.errorMessage = errorMessage
        }
    }
    
    func createEmployeeSections(with employees: [EmployeeDetails]) {
        let sortedEmployeesByName = employees
            .map { EmployeeSections(employeeType: $0.employeeType.employedStatusDescription, employee: $0 ) }
            .sortedByKeyPath(by: \.fullName)
        
        employeeSections = OrderedDictionary(grouping: sortedEmployeesByName) { $0.employeeType }
    }
}
