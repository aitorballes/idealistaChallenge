@testable import IdealistaTechTest

extension AdvertisementDetailModel {
    static func mock() -> AdvertisementDetailModel {
        return .init(
            id: 12345,
            description: "Mock advertisement description",
            price: 250000.0,
            currency: "EUR",
            propertyType: "Apartment",
            extendedPropertyType: "Residential",
            homeType: "Flat",
            state: "For Sale",
            imageUrls: ["https://example.com/image1.jpg", "https://example.com/image2.jpg"],
            latitude: 40.4168,
            longitude: -3.7038,
            roomNumber: 2,
            bathNumber: 1,
            constructedArea: 1000
        )
    }
}

extension AdvertisementDetailModel: @retroactive Equatable {
    public static func ==(lhs: AdvertisementDetailModel, rhs: AdvertisementDetailModel) -> Bool {
            return lhs.id == rhs.id
        }    
}
    
