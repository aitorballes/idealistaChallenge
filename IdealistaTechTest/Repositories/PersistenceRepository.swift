import Foundation

protocol PersistenceRepository {
    func addFavorite(id: Int)
    func removeFavorite(id: Int)
    func loadFavorites() -> [FavoriteAdvertisement]
}

struct PersistenceRepositoryImpl: PersistenceRepository {
    private let key = "favoriteAdvertisements"

    func addFavorite(id: Int) {
        var favorites = loadFavorites()
        if !favorites.contains(where: { $0.id == id }) {
            favorites.append(FavoriteAdvertisement(id: id, date: Date()))
            saveFavorites(favorites)
        }
    }

    func removeFavorite(id: Int) {
        var favorites = loadFavorites()
        favorites.removeAll { $0.id == id }
        saveFavorites(favorites)
    }
    
    func loadFavorites() -> [FavoriteAdvertisement] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        return
            (try? JSONDecoder().decode([FavoriteAdvertisement].self, from: data))
            ?? []
    }

}

extension PersistenceRepositoryImpl {
    private func saveFavorites(_ favorites: [FavoriteAdvertisement]) {
        guard let data = try? JSONEncoder().encode(favorites) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
