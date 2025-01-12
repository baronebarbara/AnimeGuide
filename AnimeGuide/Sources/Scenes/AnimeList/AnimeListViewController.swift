import UIKit

extension AnimeListViewController.Constants {
    enum Insets {
        static var tableView = UIEdgeInsets(horizontal: Spacing.space3)
        static var header = UIEdgeInsets(vertical: Spacing.space2)
    }
}

final class AnimeListViewController: UIViewController {
    fileprivate enum Constants { }
    
    private lazy var subtitleLabel = UILabel.build(type: .title, color: .systemGray2, text: "Explore os animes mais populares")
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.register(AnimeListViewCell.self, forCellReuseIdentifier: AnimeListViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        tableView.sectionHeaderHeight = .zero
        tableView.sectionFooterHeight = .zero
        tableView.delaysContentTouches = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private var viewModel: AnimeListViewModelProtocol
    private var animeList: [AnimeListViewCellViewModel] = []
    
    init(viewModel: AnimeListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animes"
        buildView()
        setupBindings()
        viewModel.fetchAnimeList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemGray
    }
    
    private func setupBindings() {
        viewModel.onAnimeListUpdate = { [weak self] animes in
            self?.animeList = animes
            self?.tableView.reloadData()
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.showErrorAlert(message: errorMessage)
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension AnimeListViewController: ViewConfiguration {
    func setupConstraints() {
        subtitleLabel.fitToParent(with: Constants.Insets.header)
        tableView.fitToParent(with: Constants.Insets.tableView)
    }
    
    func setupHierarchy() {
        view.addSubviews(subtitleLabel,
                         tableView)
    }
    
    func setupStyles() {
        view.backgroundColor = .white
    }
}

extension AnimeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimeListViewCell.identifier, for: indexPath) as? AnimeListViewCell else {
            return UITableViewCell()
        }
        
        let viewModel = animeList[indexPath.row]
        cell.setup(with: viewModel)
        return cell
    }
}

extension AnimeListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height * 1.5 {
            viewModel.fetchAnimeList()
        }
    }
}
