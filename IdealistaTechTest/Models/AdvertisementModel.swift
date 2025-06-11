import Foundation

struct AdvertisementModel {
    let id: Int
    let description: String
    let propertyType: String
    let price: Double
    let currency: String
    let thumbnailUrl: String
    let address: String
    let rooms: Int
    let bathrooms: Int
    let size: Double
    let hasParking: Bool
    let hasAirConditioning: Bool

    var title: String {
        "\(propertyType.capitalized) in \(address)"
    }

    var formattedPrice: String {
        price.formatted(
            .number
                .grouping(.automatic)
                .precision(.fractionLength(0))
        ) + " \(currency)"
    }

    var roomsText: String {
        "🛏︎ \(rooms) rooms"
    }
    
    var bathroomsText: String {
        "🛁 \(bathrooms) bathrooms"
    }
    
    var sizeText: String {
        "📐 \(size) m²"
    }
    
    var parkingText: String {
        hasParking ? "🚗 Parking included" : "🚫 No parking"
    }
    
    var acText: String {
        hasAirConditioning ? "❄️ AC" : "🔥 No AC"
    }
    
    var isFavorite: Bool
    var favoriteDate: Date?
}
