import Foundation

struct AdvertisementDTO: Codable {
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: Double
    let priceInfo: PriceInfoDTO
    let propertyType: String
    let operation: String
    let size: Double
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String
    let latitude: Double
    let longitude: Double
    let description: String
    let multimedia: MultimediaDTO
    let parkingSpace: ParkingSpaceDTO?
    let features: FeaturesDTO?
}

extension AdvertisementDTO {
    func toModel() -> AdvertisementModel {
        return .init(
            id: Int(propertyCode) ?? 0,
            description: description,
            propertyType: propertyType,
            price: price,
            currency: priceInfo.price.currencySuffix,
            thumbnailUrl: thumbnail,
            address: address,
            rooms: rooms,
            bathrooms: bathrooms,
            size: size,
            hasParking: parkingSpace?.hasParkingSpace ?? false,
            hasAirConditioning: features?.hasAirConditioning ?? false,
            isFavorite: false
        )
    }
}
