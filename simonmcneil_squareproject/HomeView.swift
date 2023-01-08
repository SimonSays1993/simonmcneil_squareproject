import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: EmployeeViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.employeeSections.isEmpty && viewModel.errorMessage.isEmpty {
                    emptyView
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                } else {
                    contentView()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .refreshable {
                        await viewModel.fetchEmployees()
                    }
                }
                
            }
            .navigationTitle(viewModel.navigationTitle)
        }
        .onAppear {
            Task {
                await viewModel.fetchEmployees()
            }
        }
    }
    
    @ViewBuilder
    func contentView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                ForEach(viewModel.employeeSections, id: \.key) { sectionDetails in
                    Section {
                        ForEach(sectionDetails.value, id: \.id) { rowDetails in
                            listRow(content: rowDetails.employee)
                        }
                    } header: {
                        Text(sectionDetails.key)
                            .font(.headline)
                    }
                    Divider()
                }
            }
        }
    }
    
    
    @ViewBuilder
    func listRow(content: EmployeeDetails) -> some View {
        HStack(alignment: .top) {
            DownloadImageView(imageUrl: content.photoUrlSmall, id: content.uuid)
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 75)
            Text(content.fullName)
                .font(.callout)
                .padding(.trailing, 20)
        }
    }
    
    var emptyView: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("No Employees Found")
            Image(systemName: "person.crop.circle.badge.exclamationmark")
                .font(.system(size: 100))
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: APIEndpoint.employeeDetails)))
    }
}
