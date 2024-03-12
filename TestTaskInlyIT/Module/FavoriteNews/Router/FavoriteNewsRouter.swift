import Foundation
import UIKit

protocol BaseFavoriteNewsProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol FavoriteNewsRouterProtocol: BaseFavoriteNewsProtocol {
   
}

class FavoriteNewsRouter: FavoriteNewsRouterProtocol {
    var builder: ModuleBuilderProtocol?
    var viewController: UIViewController?
    
    init(builder: ModuleBuilderProtocol, viewController: UIViewController) {
        self.builder = builder
        self.viewController = viewController
    }
}
