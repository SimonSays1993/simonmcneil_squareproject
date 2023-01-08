import SwiftUI

@MainActor
final class EmployeeViewModel: ObservableObject {
    @Published var employee: Employees = Employees(employees: [])
    @Published var errorMessage: String = ""
    
    private let apiService: APIService
    private let resource: Resource<Employees>

    init(apiService: APIService, resource: Resource<Employees> = Resource<Employees>()) {
        self.apiService = apiService
        self.resource = resource
    }
    
    func fetchEpisodes() async {
        do {
            employee = try await apiService.request(resource, endpoint: .employeeDetails)
        } catch {
            errorMessage = error.localizedDescription
            self.errorMessage = errorMessage
        }
    }
}
