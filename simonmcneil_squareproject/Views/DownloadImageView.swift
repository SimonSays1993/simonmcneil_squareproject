import SwiftUI

struct DownloadImageView: View {
    @StateObject var loader: ImageLoadingViewModel
    @State var isLoading: Bool = true
    
    init(imageUrl: URL?, id: String) {
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(imageUrl: imageUrl, imageKey: id))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

struct DownloadImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageView(imageUrl: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg")!, id: "1")
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}
