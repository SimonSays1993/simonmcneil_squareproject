import SwiftUI
import OrderedCollections

final class EmployeeViewModel: ObservableObject {
    @Published private(set) var employeeSections: [OrderedDictionary<Int, [EmployeeSections]>.Element] = []
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var navigationTitle: String = "Employee Directory"
    @Published private(set) var isLoaded: Bool = false
    @Published private(set) var showShyHeader: Bool = false
    
    private let apiService: APIService
    private let resource: Resource<Employees>
    
    var isEmptyView: Bool {
        employeeSections.isEmpty && errorMessage.isEmpty && isLoaded
    }

    init(apiService: APIService = ApiServiceClient(), resource: Resource<Employees>) {
        self.apiService = apiService
        self.resource = resource
    }
    
    @MainActor
    func fetchEmployees() async {
        do {
            let response = try await apiService.request(resource)
            isLoaded = true
            if response.employees.isEmpty {
                employeeSections = []
            }
            createEmployeeSections(with: response.employees)
        } catch {
            isLoaded = true
            self.navigationTitle = ""
            self.errorMessage = error.localizedDescription
        }
    }
    
    private func createEmployeeSections(with employees: [EmployeeDetails]) {
        let sortedEmployeesByName = employees
            .map { EmployeeSections(position: $0.employeeType.sectionOrder, employeePosition: $0.employeeType.employedStatusDescription, employee: $0) }
            .sortedByKeyPath(by: \.fullName)
        
        employeeSections = OrderedDictionary(grouping: sortedEmployeesByName) { $0.position }
            .sortedByKeyPath(by: \.key)
    }
}

extension EmployeeViewModel {
    func createImageModel(with employee: EmployeeDetails) -> ImageModel {
        ImageModel(id: employee.uuid, imageUrl: employee.photoUrlSmall, name: employee.fullName, team: employee.team)
    }
    
    func sectionTitle(with key: Int) -> String {
        employeeSections[key].value.first?.employeePosition ?? "Section Not Found"
    }
    
    func isShyHeaderVisibile(with offset: CGFloat) {
        showShyHeader = offset >= 139 ? false : true
    }
}
