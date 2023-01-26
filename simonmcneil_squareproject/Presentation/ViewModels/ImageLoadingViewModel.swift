import Foundation
import SwiftUI
import Combine

final class ImageLoadingViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let cacheManager: ImageCacheManager
    private(set) var imageModel: ImageModel
    
    init(imageModel: ImageModel, manager: ImageCacheManager = .instance) {
        self.imageModel = imageModel
        self.cacheManager = manager
        getImage()
    }
    
    private func getImage() {
        if let savedImage = cacheManager.get(key: imageModel.id) {
            image = savedImage
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        isLoading = true
        guard let imageUrl = imageModel.imageUrl else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: imageUrl)
            .map { return $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard let self = self, let image = UIImage(data: returnedImage.data) else {
                    self?.image = UIImage(systemName: "photo.fill")
                    return
                }
                self.cacheManager.add(key: self.imageModel.id, value: image)
                self.image = UIHelper.downsampleImage(imageData: returnedImage.data)
            }
            .store(in: &cancellables)
    }
    
    func placeHolderImage() -> UIImage {
        guard let image = UIImage(systemName: "photo.fill") else {
            return UIImage()
        }
        return image
    }
}
