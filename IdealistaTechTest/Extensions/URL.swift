import Foundation

extension URL {
    private static let baseURL = URL(string: "https://idealista.github.io/ios-challenge")!
    
    static let getAdvertisementsList = baseURL.appending(path: "/list.json")
    
    static func getAdvertisementDetail(for id: Int) -> URL {
        baseURL.appending(path: "/detail_\(id).json")
    }
}
