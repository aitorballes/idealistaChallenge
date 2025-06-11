import Foundation

struct AdvertisementDetailDTO: Codable {
    let adid: Int
    let price: Double
    let priceInfo: PriceDTO
    let operation: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let multimedia: MultimediaDTO
    let propertyComment: String
    let ubication: UbicationDTO
    let country: String
    let moreCharacteristics: MoreCharacteristicsDTO
    let energyCertification: EnergyCertificationDTO
}
extension AdvertisementDetailDTO {
    
    func toModel() -> AdvertisementDetailModel {
        return AdvertisementDetailModel(
            id: adid,
            description: propertyComment,
            price: price,
            currency: priceInfo.currencySuffix,
            propertyType: propertyType,
            extendedPropertyType: extendedPropertyType,
            homeType: homeType,
            state: state,
            imageUrls: multimedia.images.map { $0.url },
            latitude: ubication.latitude,
            longitude: ubication.longitude,
            roomNumber: moreCharacteristics.roomNumber,
            bathNumber: moreCharacteristics.bathNumber,
            constructedArea: moreCharacteristics.constructedArea
        )
    }
}





