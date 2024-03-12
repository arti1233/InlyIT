import UIKit
import Foundation
import SnapKit

protocol MainVCProtocol: AnyObject {
    
}

class MainVC: UIViewController, MainVCProtocol {

    private lazy var newsTableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .blue
        tableView.separatorStyle = .none
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.key)
        return tableView
    }()
    
    var presenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
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
}

extension MainVC: UITableViewDelegate {
    
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.key) as? NewsCell else { return UITableViewCell() }
        newsCell.updateConstraints()
        return newsCell
    }
    
    
}