import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    func createMainVC(title: String, image: UIImage?) -> UIViewController
    func createFavoriteNewsVC(title: String, image: UIImage?) -> UIViewController
    func createFullNewVC(news: Results) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
  
    func createMainVC(title: String, image: UIImage?) -> UIViewController {
        let view = MainVC()
        let alamofire = AlamofireProvider()
        let router = MainRouter(builder: self, viewController: view)
        let presenter = MainPresenter(view: view, router: router, alamofireProvider: alamofire)
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        view.presenter = presenter
        return view
    }
    
    func createFavoriteNewsVC(title: String, image: UIImage?) -> UIViewController {
        let view = FavoriteNewsVC()
        let router = FavoriteNewsRouter(builder: self, viewController: view)
        let presenter = FavoriteNewsPresenter(view: view, router: router)
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        view.presenter = presenter
        return view
    }
    
    func createFullNewVC(news: Results) -> UIViewController {
        let view = FullNewsVC()
        let router = FullNewsRouter(builder: self, viewController: view)
        let presenter = FullNewsPresenter(view: view, router: router, news: news)
        view.presenter = presenter
        return view
    }
    
}

