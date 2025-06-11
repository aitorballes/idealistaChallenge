import Foundation
@testable import IdealistaTechTest

final class MockDataRepository: DataRepository {
    var advertisementDetailResult: Result<AdvertisementDetailModel, Error>?
    var advertisementsResult: Result<[AdvertisementModel], Error>?
    

    func getAdvertisements() async throws -> [AdvertisementModel] {
            switch advertisementsResult {
            case .success(let models): return models
            case .failure(let error): throw error
            case .none: fatalError("advertisementsResult not configured")
            }
        }

    func getAdvertisementDetail(for id: Int) async throws -> AdvertisementDetailModel {
        switch advertisementDetailResult {
        case .success(let model):
            return model
        case .failure(let error):
            throw error
        case .none:
            fatalError("advertisementDetailResult not configured")
        }
    }
}
