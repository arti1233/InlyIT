protocol MainPresenterProtocol: AnyObject {
    
}

class MainPresenter: MainPresenterProtocol {

    private(set) var view: MainVCProtocol?
    private(set) var router: MainRouterProtocol?
    
    required init(view: MainVCProtocol, router: MainRouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
