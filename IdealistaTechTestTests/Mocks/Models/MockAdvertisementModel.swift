import Foundation

@testable import IdealistaTechTest

extension AdvertisementModel {
    static func mockList() -> [AdvertisementModel] {
        [
            .init(
                id: 1,
                description: "Amplio piso céntrico con vistas a la ciudad.",
                propertyType: "apartment",
                price: 250000,
                currency: "EUR",
                thumbnailUrl: "https://example.com/img1.jpg",
                address: "Gran Vía 1, Madrid",
                rooms: 3,
                bathrooms: 2,
                size: 120,
                hasParking: true,
                hasAirConditioning: true,
                isFavorite: false,
                favoriteDate: nil
            ),
            .init(
                id: 2,
                description: "Chalet luminoso con jardín privado.",
                propertyType: "house",
                price: 420000,
                currency: "EUR",
                thumbnailUrl: "https://example.com/img2.jpg",
                address: "Calle Jardín 5, Valencia",
                rooms: 4,
                bathrooms: 3,
                size: 200,
                hasParking: true,
                hasAirConditioning: false,
                isFavorite: true,
                favoriteDate: Date().addingTimeInterval(-86400)
            ),
            .init(
                id: 3,
                description:
                    "Estudio moderno, ideal para jóvenes profesionales.",
                propertyType: "studio",
                price: 150000,
                currency: "EUR",
                thumbnailUrl: "https://example.com/img3.jpg",
                address: "Avenida Sol 10, Barcelona",
                rooms: 1,
                bathrooms: 1,
                size: 45,
                hasParking: false,
                hasAirConditioning: true,
                isFavorite: false,
                favoriteDate: nil
            ),
        ]
    }

    static func mock() -> AdvertisementModel {
        return .init(
            id: 1,
            description: "Amplio piso céntrico con vistas a la ciudad.",
            propertyType: "apartment",
            price: 250000,
            currency: "EUR",
            thumbnailUrl: "https://example.com/img1.jpg",
            address: "Gran Vía 1, Madrid",
            rooms: 3,
            bathrooms: 2,
            size: 120,
            hasParking: true,
            hasAirConditioning: true,
            isFavorite: false,
            favoriteDate: nil
        )

    }
}

extension AdvertisementModel: @retroactive Equatable {
    public static func == (lhs: AdvertisementModel, rhs: AdvertisementModel)
        -> Bool
    {
        return lhs.id == rhs.id
    }
}
