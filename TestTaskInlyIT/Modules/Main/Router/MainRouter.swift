import Foundation
import UIKit

protocol BaseMainProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol MainRouterProtocol: BaseMainProtocol {
    func showFullNewsVC(news: Results)
}

class MainRouter: MainRouterProtocol {
    var builder: ModuleBuilderProtocol?
    var viewController: UIViewController?
    
    init(builder: ModuleBuilderProtocol, viewController: UIViewController) {
        self.builder = builder
        self.viewController = viewController
    }
    
    func showFullNewsVC(news: Results) {
        guard let view = builder?.createFullNewVC(news: news),
              let viewController else { return }
        view.modalPresentationStyle = .popover
        viewController.present(view, animated: true)
    }
}

