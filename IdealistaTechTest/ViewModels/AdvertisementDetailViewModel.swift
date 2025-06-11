import Foundation

final class AdvertisementDetailViewModel {
    private let repository: DataRepository
    let advertisementId: Int
    var advertisement: AdvertisementDetailModel?
    
    init(repository: DataRepository = NetworkRepository(), advertisementId: Int) {
        self.repository = repository
        self.advertisementId = advertisementId
    }
    
    func getAdvertisementDetail() async {
        do {
            advertisement = try await repository.getAdvertisementDetail(for: advertisementId)
        } catch {
            print("Error getting advertisement detail: \(error)")
        }
    }
}
