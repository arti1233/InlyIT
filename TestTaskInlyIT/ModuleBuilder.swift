import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    func createMainVC() -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
  
    func createMainVC() -> UIViewController {
        let view = MainVC()
        let router = MainRouter(builder: self, viewController: view)
        let presenter = MainPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}

