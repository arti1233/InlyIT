import Foundation
import Alamofire

protocol AlamofireProtocol {
    func getNews(completion: @escaping(Result<NewsPage, Error>) -> Void)
}

class AlamofireProvider: AlamofireProtocol {
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
    
    
    private func addParams(queryItems: [String: String]) -> [String: String] {
        var params: [String: String] = [:]
        params = queryItems
        return params
    }
}

