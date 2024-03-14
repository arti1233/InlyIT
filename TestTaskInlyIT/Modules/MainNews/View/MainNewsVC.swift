import UIKit
import Foundation
import SnapKit

protocol MainNewsVCProtocol: AnyObject {
    func reloadTableView()
}

final class MainNewsVC: UIViewController, MainNewsVCProtocol {

//MARK: Properties
    private lazy var newsTableView: UITableView = {
        var tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.key)
        tableView.showsVerticalScrollIndicator = true
        return tableView
    }()
    
    var presenter: MainNewsPresenterProtocol!
    
//MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News" 
        view.addSubview(newsTableView)
        updateViewConstraints()
    }
    
    func reloadTableView() {
        newsTableView.reloadData()
    }
    
//MARK: - Constraints
    override func updateViewConstraints() {
        super.updateViewConstraints()
        newsTableView.snp.makeConstraints {
            $0.bottom.top.trailing.leading.equalToSuperview()
            $0.top.equalTo(view.safeAreaInsets.top)
            $0.bottom.equalTo(view.safeAreaInsets.bottom)
        }
    }
}


//MARK: - Extension UITableViewDataSource
extension MainNewsVC: UITableViewDelegate {
    
}

extension MainNewsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getAmountMenuPositions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.key) as? NewsCell else { return UITableViewCell() }
        newsCell.prepareForReuse()
        newsCell.updateConstraints()
        newsCell.selectionStyle = .none
        newsCell.closureForSaveButton = { [weak self] in
            guard let self else { return }
            self.presenter.addNewsToFavorite(indexPath: indexPath)
        }
        presenter.configureNewsCell(indexPath: indexPath, cell: newsCell)
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openFullNewVC(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Conditions for loading a new news page
        if indexPath.row == presenter.getAmountMenuPositions() - 1 && presenter.newsIsLoadIndicator() == false && presenter.getAmountMenuPositions() < presenter.getMaxNews() {
            presenter.getNextPage()
        }
    }
}
