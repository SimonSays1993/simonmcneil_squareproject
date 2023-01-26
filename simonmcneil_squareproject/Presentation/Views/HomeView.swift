import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: EmployeeViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.7843137255, green: 0.4666666667, blue: 0.2, alpha: 1)).opacity(0.4), Color(#colorLiteral(red: 0.007843137255, green: 0.8549019608, blue: 0.8666666667, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                if viewModel.isEmptyView {
                    emptyView
                } else if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                } else {
                    if #available(iOS 15.0, *) {
                        contentView()
                            .refreshable {
                                await viewModel.fetchEmployees()
                            }
                    } else {
                        contentView(showRefreshButton: true)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchEmployees()
            }
            UIRefreshControl.appearance().tintColor = UIColor.white
        }
    }
    
    @ViewBuilder
    private func contentView(showRefreshButton: Bool = false) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            CustomNavBar(show: showRefreshButton) {
                Task {
                    await viewModel.fetchEmployees()
                }
            }
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewModel.employeeSections, id: \.key) { sectionDetails in
                    Section {
                        ForEach(sectionDetails.value, id: \.id) { rowDetails in
                            imageCardView(details: rowDetails.employee)
                        }
                    } header: {
                        HStack {
                            Text(viewModel.sectionTitle(with: sectionDetails.key))
                                .font(.system(.title, design: .rounded))
                                .bold()
                                .multilineTextAlignment(.leading)
                                .padding(.top, 20)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 5)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func imageCardView(details: EmployeeDetails) -> some View {
        DownloadImageView(imageModel: viewModel.createImageModel(with: details))
            .padding(.bottom, 16)
    }
    
    private var emptyView: some View {
        LazyVStack(spacing: 16) {
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
