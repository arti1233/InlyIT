import Foundation
import RealmSwift

//MARK: Model for save news in realm

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
    func isThereElementInRealm(news: NewsModel) -> Bool
    func getAllPositionInNews() -> Results<News>
    func deleteObject(news: NewsModel)
}

final class RealmService: RealmServiceProtocol {
    
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
            print("Error adding news to the database ")
        }
    }
    
    func getAllPositionInNews() -> Results<News> {
        realm.objects(News.self)
    }
    
    func getAllFavoriteNew() -> [NewsModel] {
        let favoriteNews = realm.objects(News.self)
        var arrayResults: [NewsModel] = []
        
        favoriteNews.forEach {
            let result = NewsModel(title: $0.title, 
                                   link: $0.link,
                                   content: $0.content,
                                   pubDate: $0.pubDate,
                                   imageURL: $0.imageURL)
            arrayResults.append(result)
        }
    
        return arrayResults
    }
    
    func deleteObject(news: NewsModel) {
        
        guard let news = realm.object(ofType: News.self, forPrimaryKey: news.title) else { return }

        do {
            try realm.write { realm.delete(news) }
        } catch {
            print("Error when deleting news from the database ")
        }
    }
    
    func isThereElementInRealm(news: NewsModel) -> Bool {
        guard realm.object(ofType: News.self, forPrimaryKey: "\(news.title)") != nil else { return false }
        return true
    }
}
