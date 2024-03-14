import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    func createMainVC(title: String, image: UIImage?) -> UIViewController
    func createFavoriteNewsVC(title: String, image: UIImage?) -> UIViewController
    func createFullNewVC(news: NewsModel) -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
  
    func createMainVC(title: String, image: UIImage?) -> UIViewController {
        let view = MainNewsVC()
        let alamofire = AlamofireProvider()
        let router = MainNewsRouter(builder: self, viewController: view)
        let realmService = RealmService()
        let presenter = MainNewsPresenter(view: view, router: router, alamofireProvider: alamofire, realmService: realmService)
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        view.presenter = presenter
        return view
    }
    
    func createFavoriteNewsVC(title: String, image: UIImage?) -> UIViewController {
        let view = FavoriteNewsVC()
        let realmService = RealmService()
        let router = FavoriteNewsRouter(builder: self, viewController: view)
        let presenter = FavoriteNewsPresenter(view: view, router: router, realmService: realmService)
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        view.presenter = presenter
        return view
    }
    
    func createFullNewVC(news: NewsModel) -> UIViewController {
        let view = FullNewsVC()
        let router = FullNewsRouter(builder: self, viewController: view)
        let presenter = FullNewsPresenter(view: view, router: router, news: news)
        view.presenter = presenter
        return view
    }
    
}

