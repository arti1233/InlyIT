import Foundation
import UIKit

protocol BaseFavoriteNewsProtocol {
    var builder: ModuleBuilderProtocol? { get }
    var viewController: UIViewController? { get set }
}

protocol FavoriteNewsRouterProtocol: BaseFavoriteNewsProtocol {
    func showFullNewsVC(news: NewsModel)
}

class FavoriteNewsRouter: FavoriteNewsRouterProtocol {
    var builder: ModuleBuilderProtocol?
    var viewController: UIViewController?
    
    init(builder: ModuleBuilderProtocol, viewController: UIViewController) {
        self.builder = builder
        self.viewController = viewController
    }
    
    func showFullNewsVC(news: NewsModel) {
        guard let view = builder?.createFullNewVC(news: news),
              let viewController else { return }
        view.modalPresentationStyle = .popover
        viewController.present(view, animated: true)
    }
}
