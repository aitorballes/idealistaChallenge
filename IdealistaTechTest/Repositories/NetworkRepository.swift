import Foundation

struct NetworkRepository: DataRepository, NetworkInteractor {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getAdvertisements() async throws -> [AdvertisementModel] {
        try await getData(from: .getAdvertisementsList, expecting: [AdvertisementDTO].self)
            .compactMap { $0.toModel() }
    }
    
    func getAdvertisementDetail(for id: Int) async throws -> AdvertisementDetailModel {
        try await getData(from: .getAdvertisementDetail(for: id), expecting: AdvertisementDetailDTO.self)
            .toModel()
    }
}
