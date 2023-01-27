import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: EmployeeViewModel
    @State var shouldShow: Bool = false
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.7843137255, green: 0.4666666667, blue: 0.2, alpha: 1)).opacity(0.4), Color(#colorLiteral(red: 0.007843137255, green: 0.8549019608, blue: 0.8666666667, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            if viewModel.isEmptyView {
                EmptyView()
            } else if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
            } else {
                if #available(iOS 15.0, *) {
                    contentView()
                } else {
                    contentView(showRefreshButton: true)
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
    
    private var gridItemLayout: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 2)
    }
    
    private var gridItemLayoutiPad: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 4)
    }
    
    @ViewBuilder
    private func contentView(showRefreshButton: Bool = false) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            CustomNavBar(show: showRefreshButton) {
                Task {
                    await viewModel.fetchEmployees()
                }
            }
            
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
                                .padding(.top, 20)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .trackableListScrollChange { offset in
                guard let offset = offset?.rounded() else {
                    return
                }
                viewModel.isShyHeaderVisibile(with: offset)
                withAnimation(.easeIn(duration: 0.1)) {
                    shouldShow = viewModel.showShyHeader
                }
            }
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 5)
        .padding(.horizontal)
        .overlay(alignment: .top) {
            ShyHeaderView()
                .opacity(shouldShow ? 1 : 0)
                .edgesIgnoringSafeArea(.top)
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
