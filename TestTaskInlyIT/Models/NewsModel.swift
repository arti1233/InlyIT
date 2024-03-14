import Foundation

struct NewsPage: Codable {
    let status: String
    let totalResults: Int
    let results: [NewsModel]
    let nextPage: String
}

struct NewsModel: Codable {
    let title: String
    let link: String?
    let content: String?
    let pubDate: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case title, link, pubDate
        case imageURL = "image_url"
        case content = "description"
    }
}


