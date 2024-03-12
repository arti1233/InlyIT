import UIKit

protocol MainVCProtocol: AnyObject {
    
}

class MainVC: UIViewController, MainVCProtocol {

    
    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
}

