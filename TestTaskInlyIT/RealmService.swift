import Foundation
import RealmSwift
import UIKit

class News: Object {
    @Persisted(primaryKey: true) var title: String
    @Persisted var link: String?
    @Persisted var content: String?
    @Persisted var pubDate: String
    @Persisted var imageURL: String?
}

protocol RealmServiceProtocol {
    func getAllFavoriteNew() -> [NewsModel]
    func addPositionInFavorite(news: NewsModel)
    func realmUrl()
    func isThereElementInRealm(news: NewsModel) -> Bool
    func getAllPositionInNews() -> Results<News>
    func deleteObject(news: NewsModel)
}

class RealmService: RealmServiceProtocol {
    
    private let realm = try! Realm()
    
    
    func addPositionInFavorite(news: NewsModel) {
        let realmNews = News()
        realmNews.content = news.content
        realmNews.imageURL = news.imageURL
        realmNews.link = news.link
        realmNews.title = news.title
        realmNews.pubDate = news.pubDate
        
        do {
            try realm.write { realm.add(realmNews, update: .modified) }
        } catch {
            print("Чет не получилось")
        }
    }
    
    func getAllPositionInNews() -> Results<News> {
        realm.objects(News.self)
    }
    
    func getAllFavoriteNew() -> [NewsModel] {
        let favoriteNews = realm.objects(News.self)
        var arrayResults: [NewsModel] = []
        
        favoriteNews.forEach {
            let result = NewsModel(title: $0.title, link: $0.link, content: $0.content, pubDate: $0.pubDate, imageURL: $0.imageURL)
            arrayResults.append(result)
        }
    
        return arrayResults
    }
    
    func deleteObject(news: NewsModel) {
        
        guard let news = realm.object(ofType: News.self, forPrimaryKey: news.title) else { return }

        do {
            try realm.write { realm.delete(news) }
        } catch {
            print("Чет не получилось")
        }
    }
    
    func isThereElementInRealm(news: NewsModel) -> Bool {
        let news = realm.object(ofType: News.self, forPrimaryKey: "\(news.title)")
        guard let news else { return false }
        return true
    }
    
    func realmUrl() {
        print(realm.configuration.fileURL?.description ?? "")
    }
}
