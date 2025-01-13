import UIKit

extension AnimeListViewController.Constants {
    enum Insets {
        static var title = UIEdgeInsets(vertical: Spacing.space2),
                   tableView = UIEdgeInsets(horizontal: Spacing.space3)
    }
    
    enum Strings {
        static var navTitle = "Animes",
                   titleText = "Fique por dentro dos animes mais populares",
                   errorTitle = "Error",
                   errorButton = "OK"
    }
}

final class AnimeListViewController: UIViewController {
    fileprivate enum Constants { }
    
    private lazy var titleLabel = UILabel.build(type: .highlightSecondaryTitle,
                                                color: .windsor,
                                                text: Constants.Strings.titleText)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.separatorStyle = .none
        tableView.register(AnimeListViewCell.self,
                           forCellReuseIdentifier: AnimeListViewCell.identifier)
        tableView.backgroundColor = .background
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = .zero
        tableView.sectionFooterHeight = .zero
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .grayDark
        indicator.hidesWhenStopped = true
        return indicator
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
        title = Constants.Strings.navTitle
        buildView()
        setupBindings()
        activityIndicator.startAnimating()
        viewModel.fetchAnimeList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .grayDark
    }
    
    private func setupBindings() {
        viewModel.onAnimeListUpdate = { [weak self] animes in
            self?.activityIndicator.stopAnimating()
            self?.animeList = animes
            self?.tableView.reloadData()
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.activityIndicator.stopAnimating()
            self?.showErrorAlert(message: errorMessage)
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: Constants.Strings.errorTitle,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.Strings.errorButton,
                                      style: .default))
        present(alert, animated: true)
    }
}

extension AnimeListViewController: ViewConfiguration {
    func setupConstraints() {
        titleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: UIEdgeInsets(top: Constants.Insets.title.top,
                                  left: Spacing.space3,
                                  bottom: Spacing.space0,
                                  right: Spacing.space3)
        )
        
        tableView.anchor(
            top: titleLabel.bottomAnchor,
            bottom: view.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            padding: Constants.Insets.tableView
        )
        
        activityIndicator.anchor(
            centerX: view.centerXAnchor,
            centerY: view.centerYAnchor
        )
    }
    
    func setupHierarchy() {
        view.addSubviews(titleLabel,
                         tableView,
                         activityIndicator)
    }
    
    func setupStyles() {
        view.backgroundColor = .background
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
