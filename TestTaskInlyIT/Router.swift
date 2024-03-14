import Foundation
import UIKit

protocol BaseRouter {
    var navigationTabBarController: UITabBarController? { get set }
    var builder: ModuleBuilderProtocol? { get set }
}

protocol ViewsRouterProtocol: BaseRouter {
    func initialViewControllers()
}

final class Router: ViewsRouterProtocol {
    var navigationTabBarController: UITabBarController?
    var builder: ModuleBuilderProtocol?
    
    init(navigationTabBarController: UITabBarController, builder: ModuleBuilderProtocol) {
        self.navigationTabBarController = navigationTabBarController
        self.builder = builder
    }
    
    func initialViewControllers() {
        guard let builder = builder, let navigationTabBarController = navigationTabBarController else { return }
        let mainVC = UINavigationController(rootViewController: builder.createMainVC(title: "News", image: UIImage(systemName: "newspaper")))
        let favoriteNewsVC = UINavigationController(rootViewController: builder.createFavoriteNewsVC(title: "Favorite", image: UIImage(systemName: "heart")))
        navigationTabBarController.viewControllers = [mainVC, favoriteNewsVC]
    }
}

