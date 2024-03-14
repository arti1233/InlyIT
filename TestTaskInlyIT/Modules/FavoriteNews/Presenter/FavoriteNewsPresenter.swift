import Foundation
import RealmSwift

protocol FavoriteNewsPresenterProtocol: AnyObject {
    func getAmountMenuPositions() -> Int
    func addNewsToFavorite(indexPath: IndexPath)
    func configureNewsCell(indexPath: IndexPath, cell: NewsCell)
    func openFullNewVC(indexPath: IndexPath)
}

final class FavoriteNewsPresenter: FavoriteNewsPresenterProtocol {

//MARK: Properties
    private(set) var view: FavoriteNewsProtocol?
    private(set) var router: FavoriteNewsRouterProtocol?
    private(set) var realmService: RealmServiceProtocol?
    private(set) var notificationToken: NotificationToken?
    private(set) var news: [NewsModel] = []
    
    required init(view: FavoriteNewsProtocol, router: FavoriteNewsRouterProtocol, realmService: RealmServiceProtocol) {
        self.view = view
        self.router = router
        self.realmService = realmService
        news = realmService.getAllFavoriteNew()
        
        notificationToken = realmService.getAllPositionInNews().observe { [weak self] (changes: RealmCollectionChange) in
            guard let self else { return }
            switch changes {
            default:
                self.news = realmService.getAllFavoriteNew()
                view.reloadTableView()
            }
        }
    }
  
//MARK: - Business Logic
    func getAmountMenuPositions() -> Int {
        return news.count
    }
    
    func addNewsToFavorite(indexPath: IndexPath) {
        guard let realmService else { return }
        if realmService.isThereElementInRealm(news: news[indexPath.row]) {
            realmService.deleteObject(news: news[indexPath.row])
        } else {
            realmService.addPositionInFavorite(news: news[indexPath.row])
        }
    }
    
    func configureNewsCell(indexPath: IndexPath, cell: NewsCell) {
        guard let realmService else { return }
        cell.configureNewsCell(news: news[indexPath.row], newsIsFavorite: realmService.isThereElementInRealm(news: news[indexPath.row]))
    }
    
    func openFullNewVC(indexPath: IndexPath) {
        guard let router else { return }
        router.showFullNewsVC(news: news[indexPath.row])
    }
}
