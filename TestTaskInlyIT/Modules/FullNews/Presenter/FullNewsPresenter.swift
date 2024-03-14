protocol FullNewsPresenterProtocol: AnyObject {
    
}

final class FullNewsPresenter: FullNewsPresenterProtocol {

//MARK: Properties
    private(set) var view: FullNewsProtocol?
    private(set) var router: FullNewsRouterProtocol?
    private(set) var news: NewsModel
    
    required init(view: FullNewsProtocol, router: FullNewsRouterProtocol, news: NewsModel) {
        self.view = view
        self.router = router
        self.news = news
        view.configureVC(news: news)
    }
}
