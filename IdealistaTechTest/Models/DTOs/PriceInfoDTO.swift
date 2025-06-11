struct PriceInfoDTO: Codable {
    let price: PriceDTO
}

struct PriceDTO: Codable {
    let amount: Double
    let currencySuffix: String
}
