import Foundation
import UIKit
import SnapKit
import Kingfisher

protocol FullNewsProtocol {
    func configureVC(news: Results)
}

class FullNewsVC: UIViewController, FullNewsProtocol {
    
    var presenter: FullNewsPresenterProtocol!
    
    private lazy var newsImage: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()
    
    private lazy var pubDateLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(newsImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(pubDateLabel)
        updateViewConstraints()
    }
    
    func configureVC(news: Results) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        pubDateLabel.text = news.pubDate
        guard let imageUrl = news.imageURL else {
            newsImage.image = UIImage(systemName: "person.fill")
            return
        }
        
        newsImage.kf.setImage(with: URL(string: "\(imageUrl)"))
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        newsImage.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(view.frame.height / 3)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(newsImage.snp.bottom).offset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        pubDateLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(32)
        }
    }

}
