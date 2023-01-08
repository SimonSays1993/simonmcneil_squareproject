import SwiftUI

struct HomeView: View {
    @StateObject var vm: EmployeeViewModel
    
    var body: some View {
        ZStack {
            List(vm.employee.employees, id: \.uuid) { employee in
                Text(employee.fullName)
            }
        }
        .onAppear {
            Task {
                await vm.fetchEpisodes()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: EmployeeViewModel(apiService: ApiPreviewClient()))
    }
}
