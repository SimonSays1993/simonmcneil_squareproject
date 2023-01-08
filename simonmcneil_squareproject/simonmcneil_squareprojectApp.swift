import SwiftUI

@main
struct simonmcneil_squareprojectApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: EmployeeViewModel(apiService: ApiServiceClient(), resource: .init(endPoint: APIEndpoint.employeeDetails)))
        }
    }
}
