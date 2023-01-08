import Foundation

struct InfoPlistParser {
    static let shared: InfoPlistParser = InfoPlistParser()
    private init () { }
    
    func configUrl(key: String) -> String {
        guard let path = Bundle.main.path(forResource: "Urls", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let urlStringPath = dict[key] as? String else {
            return ""
        }
        return urlStringPath
    }
}
