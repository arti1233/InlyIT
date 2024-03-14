import Foundation

struct NewsPage: Decodable {
    let status: String
    let totalResults: Int
    let results: [NewsModel]
    let nextPage: String
}

struct NewsModel: Decodable {
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


