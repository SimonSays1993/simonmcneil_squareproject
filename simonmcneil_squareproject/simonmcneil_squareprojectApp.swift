import SwiftUI

@main
struct simonmcneil_squareprojectApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(vm: EmployeeViewModel(apiService: ApiClient()))
        }
    }
}
