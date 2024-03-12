protocol FavoriteNewsPresenterProtocol: AnyObject {
    
}

class FavoriteNewsPresenter: FavoriteNewsPresenterProtocol {

    private(set) var view: FavoriteNewsProtocol?
    private(set) var router: FavoriteNewsRouterProtocol?
    
    required init(view: FavoriteNewsProtocol, router: FavoriteNewsRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
