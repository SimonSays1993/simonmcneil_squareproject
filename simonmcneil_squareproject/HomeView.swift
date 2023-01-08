import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: EmployeeViewModel
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.employeeSections, id: \.key) { sectionDetails in
                    Section {
                        ForEach(sectionDetails.value, id: \.uuid) { rowDetails in
                            Text(rowDetails.fullName)
                        }
                    } header: {
                        Text(sectionDetails.key)
                    }
                }
            }
            .listStyle(.grouped)
        }
        .onAppear {
            Task {
                await viewModel.fetchEpisodes()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: EmployeeViewModel(apiService: ApiPreviewClient()))
    }
}
