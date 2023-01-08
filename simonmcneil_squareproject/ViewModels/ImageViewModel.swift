import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    let imageUrl: URL?
    let imageKey: String
    var cancellables = Set<AnyCancellable>()
    let manager: ImageCacheManager
    
    init(imageUrl: URL?, imageKey: String, manager: ImageCacheManager = .instance) {
        self.imageUrl = imageUrl
        self.imageKey = imageKey
        self.manager = manager
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
        } else {
            downloadImage()
        }
    }
    
    func downloadImage() {
        isLoading = true
        guard let imageUrl = imageUrl else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: imageUrl)
            //Here we don't care about the error so that is why we are not using tryMap
            .map { return $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard let self = self, let image = UIImage(data: returnedImage.data) else {
                    return
                }
                self.manager.add(key: self.imageKey, value: image)
                self.image = UIHelper.downsampleImage(imageData: returnedImage.data)
            }
            .store(in: &cancellables)
    }
}
