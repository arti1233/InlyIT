import Foundation
import Alamofire

struct Constants {
    static var newsUrl = "https://newsdata.io/api/1/news?apikey=pub_398848ae5b1fb6e4db34a099b033237e361e8"
}

protocol AlamofireProtocol {
    func getNews(completion: @escaping(Result<NewsPage, Error>) -> Void)
    func getNextPage(nextPageId: String, completion: @escaping (Result<NewsPage, any Error>) -> Void)
}

final class AlamofireProvider: AlamofireProtocol {
    func getNews(completion: @escaping (Result<NewsPage, any Error>) -> Void) {
        let params = addParams(queryItems: ["language": "ru"])
        
        AF.request(Constants.newsUrl, method: .get, parameters: params).responseDecodable(of: NewsPage.self) { response in
            switch response.result {
            case .success(let result):
                return completion(.success(result))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    func getNextPage(nextPageId: String, completion: @escaping (Result<NewsPage, any Error>) -> Void) {
        let params = addParams(queryItems: ["language": "ru", "page": nextPageId])
        AF.request(Constants.newsUrl, method: .get, parameters: params).responseDecodable(of: NewsPage.self) { response in
            switch response.result {
            case .success(let result):
                return completion(.success(result))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    private func addParams(queryItems: [String: String]) -> [String: String] {
        var params: [String: String] = [:]
        params = queryItems
        return params
    }
}

