import SwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @ObservedObject var viewModel: EmployeeViewModel
    @State var shouldShow: Bool = false
    
    private var gridItemLayout: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 2)
    }
    
    private var gridItemLayoutiPad: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 4)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.7843137255, green: 0.4666666667, blue: 0.2, alpha: 1)).opacity(0.4), Color(#colorLiteral(red: 0.007843137255, green: 0.8549019608, blue: 0.8666666667, alpha: 1))]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    if viewModel.isEmptyView {
                        EmptyView()
                    } else if  !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                    }  else {
                        sectionView()
                    }
                }
                .refreshable {
                    await viewModel.fetchEmployees()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            Task {
                                await viewModel.fetchEmployees()
                            }
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.black)
                                .font(.system(.title3, design: .rounded))
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image("block")
                            .resizable()
                            .frame(width: 54, height: 54)
                            .offset(x: -11)
                    }
                    
                }
            }
            .navigationTitle("Employees")
        }
        .task {
            await viewModel.fetchEmployees()
        }
        .onAppear {
            UIRefreshControl.appearance().tintColor = UIColor.white
        }
        .navigationBarColor(.clear, titleColor: .white)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    @ViewBuilder
    private func sectionView() -> some View {
        if #available(iOS 16.0, *) {
            contentView()
        } else {
            contentView(showRefreshButton: true)
        }
    }
    
    @ViewBuilder
    private func contentView(showRefreshButton: Bool = true) -> some View {
        VStack(spacing: 2) {
            HStack {
                Text("Lets meet some employees!")
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(.title, design: .rounded))
                Spacer()
            }
            .padding(.top, 12)
            .padding(.horizontal)

            LazyVGrid(columns: sizeClass == .regular ? gridItemLayoutiPad : gridItemLayout) {
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
                                .padding(.top, 10)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .buttonStyle(StaticButtonStyle())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private func imageCardView(details: EmployeeDetails) -> some View {
        DownloadImageView(imageModel: viewModel.createImageModel(with: details))
            .padding(.bottom, 16)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: EmployeeViewModel(apiService: ApiPreviewClient(), resource: .init(endPoint: APIEndpoint.employeeDetails)))
    }
}
