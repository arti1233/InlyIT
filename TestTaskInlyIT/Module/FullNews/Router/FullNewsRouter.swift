import Foundation
import UIKit

protocol BaseFullNewsProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol FullNewsRouterProtocol: BaseFullNewsProtocol {
   
}

class FullNewsRouter: FullNewsRouterProtocol {
    var builder: ModuleBuilderProtocol?
    var viewController: UIViewController?
    
    init(builder: ModuleBuilderProtocol, viewController: UIViewController) {
        self.builder = builder
        self.viewController = viewController
    }
}

