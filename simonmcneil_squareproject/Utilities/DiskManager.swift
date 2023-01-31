import Foundation
import UIKit

class DiskManager {
    static let instance = DiskManager()
    let folderName = "output.txt"
    
    private init() { }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func add(employee: Employees) throws {
        let filename = getDocumentsDirectory().appendingPathComponent(folderName)
        
        do {
            try JSONEncoder().encode(employee).write(to: filename)
        } catch {
            throw DiskCachingError.decodeError
        }
    }
    
    func read() throws -> Data? {
        let url = getDocumentsDirectory().appendingPathComponent(folderName)
        
        do {
            return try Data(contentsOf: url)
        } catch {
            throw DiskCachingError.folderNotCreated
        }
    }
}
