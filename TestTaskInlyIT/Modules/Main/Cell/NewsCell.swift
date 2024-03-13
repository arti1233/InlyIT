import Foundation
import UIKit
import SnapKit
import Kingfisher

protocol NewsCellProtocol {
    func configureNewsCell(news: Results)
}

class NewsCell: UITableViewCell, NewsCellProtocol {
    
    static var key = "NewsCell"
    
    private lazy var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 5, height: 4)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var icon: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage(systemName: "person.fill")
        return view
    }()
    
    private lazy var title: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var pubDate: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 3
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(mainView)
        mainView.addSubview(icon)
        mainView.addSubview(title)
        mainView.addSubview(pubDate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        pubDate.text = ""
        icon.image = UIImage(systemName: "person.fill")
    }
    
    func configureNewsCell(news: Results) {
        title.text = news.title
        pubDate.text = news.pubDate 
        
        guard let imageUrl = news.imageURL else {
            icon.image = UIImage(systemName: "person.fill")
            return
        }
        
        icon.kf.setImage(with: URL(string: "\(imageUrl)"))
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        mainView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview().inset(8)
        }
        
        icon.snp.makeConstraints {
            $0.height.equalTo(132)
            $0.width.equalTo(132)
            $0.top.bottom.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(8)
        }
        
        title.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).offset(32)
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(16)
        }
                
        pubDate.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.leading.equalTo(icon.snp.trailing).offset(32)
            $0.trailing.equalToSuperview().inset(24)
        }
    }
}
