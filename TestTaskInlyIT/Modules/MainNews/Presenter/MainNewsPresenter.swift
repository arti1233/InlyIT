import Foundation
import UIKit
import RealmSwift

protocol MainNewsPresenterProtocol: AnyObject {
    func configureNewsCell(indexPath: IndexPath, cell: NewsCell)
    func getAmountMenuPositions() -> Int
    func newsIsLoadIndicator() -> Bool
    func getNextPage()
    func openFullNewVC(indexPath: IndexPath)
    func getMaxNews() -> Int
    func addNewsToFavorite(indexPath: IndexPath)
}

final class MainNewsPresenter: MainNewsPresenterProtocol {
  
//MARK: Properties
    private(set) var view: MainNewsVCProtocol?
    private(set) var router: MainNewsRouterProtocol?
    private(set) var alamofireProvider: AlamofireProtocol?
    private(set) var realmService: RealmServiceProtocol?
    private(set) var news: [NewsModel] = []
    private(set) var nextPageId: String = ""
    private(set) var newsIsLoad = true
    private(set) var maxNews = 120
    private(set) var notificationToken: NotificationToken?
    
    required init(view: MainNewsVCProtocol, router: MainNewsRouterProtocol, alamofireProvider: AlamofireProtocol, realmService: RealmServiceProtocol) {
        self.view = view
        self.router = router
        self.alamofireProvider = alamofireProvider
        self.realmService = realmService
        getNews()
        
        notificationToken = realmService.getAllPositionInNews().observe { (changes: RealmCollectionChange) in
            switch changes {
            default :
                view.reloadTableView()
            }
        }
    }

//MARK: - Business Logic
    func addNewsToFavorite(indexPath: IndexPath) {
        guard let realmService else { return }
        if realmService.isThereElementInRealm(news: news[indexPath.row]) {
            realmService.deleteObject(news: news[indexPath.row])
        } else {
            realmService.addPositionInFavorite(news: news[indexPath.row])
        }
    }
    
    func getMaxNews() -> Int {
        maxNews
    }
    
    func configureNewsCell(indexPath: IndexPath, cell: NewsCell) {
        guard let realmService else { return }
        cell.configureNewsCell(news: news[indexPath.row], newsIsFavorite: realmService.isThereElementInRealm(news: news[indexPath.row]))
    }
    
    func getAmountMenuPositions() -> Int {
        return news.count
    }
    
    func newsIsLoadIndicator() -> Bool {
        newsIsLoad
    }

    func getNews() {
        guard let alamofireProvider else { return }
        alamofireProvider.getNews { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    success.results.forEach { self.news.append($0) }
                    self.nextPageId = success.nextPage
                    self.view?.reloadTableView()
                    self.newsIsLoad = false
                case .failure:
                    print("Error loading news")
                }
            }
        }
    }
    
    func getNextPage() {
        newsIsLoad = true
        guard let alamofireProvider else { return }
        alamofireProvider.getNextPage(nextPageId: nextPageId) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    success.results.forEach { self.news.append($0) }
                    self.nextPageId = success.nextPage
                    self.newsIsLoad = false
                    self.view?.reloadTableView()
                case .failure:
                    print("Error loading the next news page ")
                }
            }
        }
    }
 
    func openFullNewVC(indexPath: IndexPath) {
        guard let router else { return }
        router.showFullNewsVC(news: news[indexPath.row])
    }
}
