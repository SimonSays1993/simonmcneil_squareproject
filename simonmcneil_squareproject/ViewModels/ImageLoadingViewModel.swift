import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let diskManager: DiskManager
    private(set) var imageModel: ImageModel
    
    init(imageModel: ImageModel, manager: DiskManager = .instance) {
        self.imageModel = imageModel
        self.diskManager = manager
        getImage()
    }
    
    func getImage() {
//        if let savedImage = diskManager.get(key: imageModel.id) {
//            image = savedImage
//        } else {
//            downloadImage()
//        }
    }
    
    func downloadImage() {
        isLoading = true
        guard let imageUrl = imageModel.imageUrl else {
            isLoading = false
            return
        }
    }
}
