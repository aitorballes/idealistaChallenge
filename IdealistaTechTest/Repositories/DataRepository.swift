protocol DataRepository {
    func getAdvertisements() async throws -> [AdvertisementModel]
    func getAdvertisementDetail(for id: Int) async throws -> AdvertisementDetailModel
}
