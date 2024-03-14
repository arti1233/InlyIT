import Foundation
import UIKit
import SnapKit
import Kingfisher

protocol FullNewsProtocol {
    func configureVC(news: NewsModel)
}

final class FullNewsVC: UIViewController, FullNewsProtocol {
    
//MARK: Properties
    private lazy var newsImage: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
        var textView = UITextView()
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        textView.font = UIFont.systemFont(ofSize: 19)
        return textView
    }()
    
    var presenter: FullNewsPresenterProtocol!

//MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(newsImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionTextView)
        updateViewConstraints()
    }

//MARK: Business Logic
    func configureVC(news: NewsModel) {
        titleLabel.text = news.title
        descriptionTextView.text = "\(news.content ?? "") \n \n\(news.pubDate) \n \n\(news.link ?? "")"
        guard let imageUrl = news.imageURL else { return }
        newsImage.loadImage(imageUrl: imageUrl)
    }
    
//MARK: Constraints
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        newsImage.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(view.frame.height / 3.5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.equalTo(newsImage.snp.bottom).offset(8)
        }
        
        descriptionTextView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(8)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
}
