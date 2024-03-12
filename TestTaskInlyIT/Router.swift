import Foundation
import UIKit

protocol BaseRouter {
    var navigationTabBarController: UITabBarController? { get set }
    var builder: ModuleBuilderProtocol? { get set }
}

protocol ViewsRouterProtocol: BaseRouter {
    func initialViewControllers()
}

class Router: ViewsRouterProtocol {
    var navigationTabBarController: UITabBarController?
    var builder: ModuleBuilderProtocol?
    
    init(navigationTabBarController: UITabBarController, builder: ModuleBuilderProtocol) {
        self.navigationTabBarController = navigationTabBarController
        self.builder = builder
    }
    
    func initialViewControllers() {
        guard let builder = builder, let navigationTabBarController = navigationTabBarController else { return }
        let mainVC = UINavigationController(rootViewController: builder.createMainVC(title: "News", image: UIImage(systemName: "person.fill")))
        let favoriteNewsVC = UINavigationController(rootViewController: builder.createFavoriteNewsVC(title: "Favorite", image: UIImage(systemName: "person.fill")))
        navigationTabBarController.viewControllers = [mainVC, favoriteNewsVC]
    }
}

