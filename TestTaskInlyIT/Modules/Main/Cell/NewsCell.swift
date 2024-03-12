import Foundation
import UIKit
import SnapKit

protocol NewsCellProtocol {
    
}

class NewsCell: UITableViewCell, NewsCellProtocol {
    
    static var key = "NewsCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
