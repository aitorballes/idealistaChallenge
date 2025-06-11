struct MultimediaDTO: Codable {
    let images: [ImageDTO]
}

struct ImageDTO: Codable {
    let url: String
    let tag: String
}
