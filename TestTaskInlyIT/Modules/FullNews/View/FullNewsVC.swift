import UIKit
import Foundation
import SnapKit

protocol FullNewsProtocol: AnyObject {
    
}

class FullNewsVC: UIViewController, FullNewsProtocol {
    
    var presenter: FullNewsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
    }
    
}

