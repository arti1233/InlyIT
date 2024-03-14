import UIKit
import Foundation
import SnapKit

protocol FavoriteNewsProtocol: AnyObject {
    func reloadTableView()
}

class FavoriteNewsVC: UIViewController, FavoriteNewsProtocol {

    private lazy var newsTableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.key)
        tableView.showsVerticalScrollIndicator = true
        return tableView
    }()
    
    var presenter: FavoriteNewsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сохраненные статьи"
        view.addSubview(newsTableView)
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        newsTableView.snp.makeConstraints {
            $0.bottom.top.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func reloadTableView() {
        newsTableView.reloadData()
    }
}

extension FavoriteNewsVC: UITableViewDelegate {
    
}

extension FavoriteNewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getAmountMenuPositions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.key) as? NewsCell else { return UITableViewCell() }
        newsCell.prepareForReuse()
        newsCell.updateConstraints()
        newsCell.selectionStyle = .none
        newsCell.closureForSaveButton = {
            self.presenter.addNewsToFavorite(indexPath: indexPath)
        }
        presenter.configureNewsCell(indexPath: indexPath, cell: newsCell)
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openFullNewVC(indexPath: indexPath)
    }
}
