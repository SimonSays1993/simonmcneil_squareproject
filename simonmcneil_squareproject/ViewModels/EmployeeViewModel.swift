import SwiftUI
import OrderedCollections

final class EmployeeViewModel: ObservableObject {
    @Published private(set) var employeeSections: [OrderedDictionary<String, [EmployeeSections]>.Element] = []
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var navigationTitle: String = "Employee Directory"
    
    private let apiService: APIService
    private let resource: Resource<Employees>

    init(apiService: APIService = ApiServiceClient(), resource: Resource<Employees>) {
        self.apiService = apiService
        self.resource = resource
    }
    
    @MainActor
    func fetchEmployees() async {
        do {
            try isCached()
            let response = try await apiService.request(resource)
            if response.employees.isEmpty {
                employeeSections = []
            }
            try DiskManager.instance.add(employee: response)
            createEmployeeSections(with: response.employees)
        } catch {
            self.navigationTitle = ""
            self.errorMessage = error.localizedDescription
        }
    }
    
    private func isCached() throws {
        do {
            let response = try DiskManager.instance.read()
        } catch {
            throw DiskCachingError.decodeError
        }
    }
    
    private func createEmployeeSections(with employees: [EmployeeDetails]) {
        let sortedEmployeesByName = employees
            .map { EmployeeSections(employeeType: $0.employeeType.employedStatusDescription, employee: $0 ) }
            .sortedByKeyPath(by: \.fullName)
        
        employeeSections = OrderedDictionary(grouping: sortedEmployeesByName) { $0.employeeType }
            .sortedByKeyPath(by: \.key)
    }
    
    func createImageModel(with employee: EmployeeDetails) -> ImageModel {
        ImageModel(id: employee.uuid, imageUrl: employee.photoUrlSmall, name: employee.fullName, team: employee.fullName)
    }
}
