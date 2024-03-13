import Foundation
import UIKit

protocol MainPresenterProtocol: AnyObject {
    func configureNewsCell(indexPath: IndexPath, cell: NewsCell)
    func getAmountMenuPositions() -> Int
    func newsIsLoadIndicator() -> Bool
    func getNextPage()
    func test()
    func openFullNewVC(indexPath: IndexPath)
    func getMaxNews() -> Int
}

class MainPresenter: MainPresenterProtocol {
    
    private(set) var view: MainVCProtocol?
    private(set) var router: MainRouterProtocol?
    private(set) var alamofireProvider: AlamofireProtocol?
    private(set) var news: [Results] = []
    private(set) var imageCache = NSCache<NSString, UIImage>()
    private(set) var nextPageId: String = ""
    private(set) var newsIsLoad = true
    private(set) var maxNews = 120
    
    required init(view: MainVCProtocol, router: MainRouterProtocol, alamofireProvider: AlamofireProtocol) {
        self.view = view
        self.router = router
        self.alamofireProvider = alamofireProvider
        getNews()
    }
    
    func getMaxNews() -> Int {
        maxNews
    }
    
    func configureNewsCell(indexPath: IndexPath, cell: NewsCell) {
        cell.configureNewsCell(news: news[indexPath.row])
    }
    
    func getAmountMenuPositions() -> Int {
        return news.count
    }
    
    func newsIsLoadIndicator() -> Bool {
        newsIsLoad
    }
    
    func test() {
        newsIsLoad = true
    }
    
    func getNews() {
        guard let alamofireProvider else { return }
        alamofireProvider.getNews { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    success.results.forEach {
                        self.news.append($0)
                    }
                    self.nextPageId = success.nextPage
                    self.view?.reloadTableView()
                    self.newsIsLoad = false
                    print("Пришли новости")
                case .failure:
                    print("НЕ пришли новости")
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
                    success.results.forEach {
                        self.news.append($0)
                    }
                    self.nextPageId = success.nextPage
                    self.newsIsLoad = false
                    self.view?.reloadTableView()
                    print("Пришли новости next page")
                case .failure:
                    print("НЕ пришли новости next page")
                }
            }
        }
    }
 
    func openFullNewVC(indexPath: IndexPath) {
        guard let router else { return }
        router.showFullNewsVC(news: news[indexPath.row])
    }
    
}
