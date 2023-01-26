import Foundation
import UIKit

class ImageDiskFileManager {
    
    static let instance = ImageDiskFileManager()
    let folderName = "download_photos"

    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else {
            return
        }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("created folder")
            } catch {
                print("Error creating folder: \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent("download_photos", conformingTo: .jpeg)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {
            return nil
        }
        return folder.appendingPathComponent(key, conformingTo: .jpeg)
    }
    
    func add(key: String, value: UIImage) {
        guard let data = value.jpegData(compressionQuality: 1), let url = getImagePath(key: key) else {
            return
        }
            
        do {
            try data.write(to: url)
        } catch {
            print("Error saving to file manager: \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard let url = getImagePath(key: key), FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
}
