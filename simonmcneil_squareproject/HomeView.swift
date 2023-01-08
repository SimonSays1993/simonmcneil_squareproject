import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: EmployeeViewModel
    
    var body: some View {
        NavigationView {
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
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .onAppear {
                Task {
                    await viewModel.fetchEmployees()
                }
            }
            .navigationTitle("Employee Directory")
            .refreshable {
                await viewModel.fetchEmployees()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: APIEndpoint.employeeDetails)))
    }
}
