import SwiftUI

struct DownloadImageView: View {
    @StateObject var imageLoadingViewModel: ImageLoadingViewModel
    @State var isLoading: Bool = true
        
    init(imageModel: ImageModel) {
        _imageLoadingViewModel = StateObject(wrappedValue: ImageLoadingViewModel(imageModel: imageModel))
    }
    
    var body: some View {
        ZStack {
            if imageLoadingViewModel.isLoading {
                ProgressView()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 200)
            } else if let image = imageLoadingViewModel.image {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 200)
                        .overlay(
                            ZStack(alignment: .bottom) {
                                Rectangle()
                                    .fill(
                                        // Having the progress changes the gradient when you scroll
                                        .linearGradient(colors: [
                                            .black.opacity(0),
                                            .black.opacity(0.2),
                                            .black.opacity(0.5),
                                            .black.opacity(0.8),
                                        ], startPoint: .top, endPoint: .bottom)
                                    )
                            }
                        )
                        .cornerRadius(6.0)
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(imageLoadingViewModel.imageModel.name)
                            .foregroundColor(.white)
                            .bold()
                        Text(imageLoadingViewModel.imageModel.team)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)
                    .padding(.horizontal, 8)
                }
            }
        }
    }
}

struct DownloadImageView_Previews: PreviewProvider {
    static var previews: some View {
        let imageURL = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg")!
        let imageModel = ImageModel(id: "", imageUrl: imageURL, name: "", team: "")
        DownloadImageView(imageModel: imageModel)
            .frame(width: 175, height: 200)
            .previewLayout(.sizeThatFits)
    }
}
