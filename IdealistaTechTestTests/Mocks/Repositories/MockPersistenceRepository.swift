import Foundation
@testable import IdealistaTechTest

final class MockPersistenceRepository: PersistenceRepository {
    var favorites: [FavoriteAdvertisement] = []
    var addFavoriteCalledWith: Int?
    var removeFavoriteCalledWith: Int?
    func addFavorite(id: Int) { addFavoriteCalledWith = id }
    func removeFavorite(id: Int) { removeFavoriteCalledWith = id }
    func loadFavorites() -> [FavoriteAdvertisement] { favorites }
}
