import Foundation

struct NewsPage: Codable {
    let status: String
    let totalResults: Int
    let results: [Results]
    let nextPage: String
}

struct Results: Codable {
    let title: String
    let link: URL?
    let description: String?
    let pubDate: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case title, link , description, pubDate
        case imageURL = "image_url"
    }
}


