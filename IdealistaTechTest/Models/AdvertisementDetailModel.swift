struct AdvertisementDetailModel {
    let id: Int
    let description: String
    let price: Double
    let currency: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let imageUrls: [String]
    let latitude: Double
    let longitude: Double

    let roomNumber: Int
    let bathNumber: Int
    let constructedArea: Int

    var formattedPrice: String {
        price.formatted(.number.grouping(.automatic).precision(.fractionLength(0))) + " \(currency)"
    }

    var fullPropertyType: String {
        "\(propertyType.capitalized) - \(extendedPropertyType.capitalized)"
    }

    var roomsText: String { "🛏 Rooms: \(roomNumber)" }
    var bathroomsText: String { "🛁 Baths: \(bathNumber)" }
    var sizeText: String { "📐 Size: \(constructedArea) m²" }

    var title: String {
        fullPropertyType
    }

    var parkingText: String {
        "🚗 Parking: No available"
    }

    var acText: String {
        "❄ AC: No available"
    }
}
