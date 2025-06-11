import Foundation

final class AdvertisementListViewModel {
    let repository: DataRepository
    let persistenceRepository: PersistenceRepository
    
    var advertisements: [AdvertisementModel] = []
    
    init(repository: DataRepository = NetworkRepository(), persistenceRepository: PersistenceRepository = PersistenceRepositoryImpl()) {
        self.repository = repository
        self.persistenceRepository = persistenceRepository
    }
    
    func getAdvertisements() async {
        do {
            advertisements = try await repository.getAdvertisements()
            let favorites = persistenceRepository.loadFavorites()
            advertisements = advertisements.map { advertisement in
                guard let favorite = favorites.first(where: { $0.id == advertisement.id }) else {
                    return advertisement
                }
                
                var updatedAdvertisement = advertisement
                updatedAdvertisement.isFavorite = true
                updatedAdvertisement.favoriteDate = favorite.date
                return updatedAdvertisement
            }
            
        } catch {
            print("Error getting advertisements: \(error)")
        }
    }
    
    func toggleFavorite(advertisement: AdvertisementModel) {
        guard let index = advertisements.firstIndex(where: { $0.id == advertisement.id }) else {
            return
        }
        
        if advertisements[index].isFavorite {
            persistenceRepository.removeFavorite(id: advertisement.id)
        }else {
            persistenceRepository.addFavorite(id: advertisement.id)
            advertisements[index].favoriteDate = Date()
        }
        
        advertisements[index].isFavorite.toggle()
    }
}
