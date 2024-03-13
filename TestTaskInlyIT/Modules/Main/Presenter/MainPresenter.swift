import Foundation
import UIKit

protocol MainPresenterProtocol: AnyObject {
    func configureNewsCell(indexPath: IndexPath, cell: NewsCell)
    func getAmountMenuPositions() -> Int
}

class MainPresenter: MainPresenterProtocol {

    private(set) var view: MainVCProtocol?
    private(set) var router: MainRouterProtocol?
    private(set) var alamofireProvider: AlamofireProtocol?
    private(set) var news: NewsPage?
    private(set) var imageCache = NSCache<NSString, UIImage>()
    
    required init(view: MainVCProtocol, router: MainRouterProtocol, alamofireProvider: AlamofireProtocol) {
        self.view = view
        self.router = router
        self.alamofireProvider = alamofireProvider
        getNews()
    }
    
    func configureNewsCell(indexPath: IndexPath, cell: NewsCell) {
        guard let news = news?.results else { return }
        cell.configureNewsCell(news: news[indexPath.row])
    }
    
    func getAmountMenuPositions() -> Int {
        guard let news = news?.results else { return 0 }
        return news.count
    }
    
    func getNews() {
        guard let alamofireProvider else { return }
        alamofireProvider.getNews { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.news = success
                    guard let news = self.news else { return }
                    self.view?.reloadTableView()
                    print("Пришли новости")
                case .failure:
                    print("НЕ пришли новости")
                }
            }
        }
    }
}
