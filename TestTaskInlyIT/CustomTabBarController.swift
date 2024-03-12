import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .purple
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 0.765, green: 0.77, blue: 0.788, alpha: 1)
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = .zero
        tabBar.layer.shadowRadius = 5
    }
}
