import UIKit
import Foundation
import SnapKit

protocol FavoriteNewsProtocol: AnyObject {
    
}

class FavoriteNewsVC: UIViewController, FavoriteNewsProtocol {


    var presenter: FavoriteNewsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
