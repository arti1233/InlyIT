import Foundation
import UIKit

protocol BaseRouter {
    var viewController: UIViewController? { get set }
    var builder: ModuleBuilderProtocol? { get set }
}

protocol ViewsRouterProtocol: BaseRouter {
    func initialViewController()
}

class Router: ViewsRouterProtocol {
    var viewController: UIViewController?
    var builder: ModuleBuilderProtocol?
    
    init(viewController: UIViewController, builder: ModuleBuilderProtocol) {
        self.viewController = viewController
        self.builder = builder
    }
    
    func initialViewController() {
        guard let builder = builder, let viewController = viewController else { return }
        let mainVC = viewController
    }
}

