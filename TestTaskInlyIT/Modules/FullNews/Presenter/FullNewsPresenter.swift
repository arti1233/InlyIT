protocol FullNewsPresenterProtocol: AnyObject {
    
}

class FullNewsPresenter: FullNewsPresenterProtocol {

    private(set) var view: FullNewsProtocol?
    private(set) var router: FullNewsRouterProtocol?
    
    required init(view: FullNewsProtocol, router: FullNewsRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
