protocol FullNewsPresenterProtocol: AnyObject {
    
}

class FullNewsPresenter: FullNewsPresenterProtocol {

    private(set) var view: FullNewsProtocol?
    private(set) var router: FullNewsRouterProtocol?
    private(set) var news: Results
    
    required init(view: FullNewsProtocol, router: FullNewsRouterProtocol, news: Results) {
        self.view = view
        self.router = router
        self.news = news
        view.configureVC(news: news)
        print(news.imageURL)
    }
    
}
