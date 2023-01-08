import SwiftUI

@main
struct simonmcneil_squareprojectApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: EmployeeViewModel(apiService: ApiClient(), resource: .init(endPoint: APIEndpoint.employeeDetails)))
        }
    }
}
