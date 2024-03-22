import Foundation
import UIKit

protocol BaseMainNewsProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol MainNewsRouterProtocol: BaseMainNewsProtocol {
    func showFullNewsVC(news: NewsModel)
}

final class MainNewsRouter: MainNewsRouterProtocol {
    
    var builder: ModuleBuilderProtocol?
    var viewController: UIViewController?
    
    init(builder: ModuleBuilderProtocol, viewController: UIViewController) {
        self.builder = builder
        self.viewController = viewController
    }
    
    func showFullNewsVC(news: NewsModel) {
        guard let view = builder?.createFullNewVC(news: news),
              let viewController else { return }
        view.modalPresentationStyle = .automatic
        viewController.present(view, animated: true)
    }
}

