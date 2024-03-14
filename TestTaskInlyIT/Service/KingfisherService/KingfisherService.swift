import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func loadImage(imageUrl: String) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(systemName: "photo"))
    }
}
