import UIKit

class AdvertisementListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        title = "Advertisements"
        view.backgroundColor = .systemBackground
        setupTableView()
        fetchData()
    }
    
    // MARK: - Private properties
    private let tableView = UITableView()
    private let viewModel = AdvertisementListViewModel()
    private let refreshControl = UIRefreshControl()

    
    // MARK: - Private methods
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            AdvertisementCell.self,
            forCellReuseIdentifier: AdvertisementCell.reuseIdentifier
        )
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func fetchData() {
        Task {
            await viewModel.getAdvertisements()
            tableView.reloadData()
        }
    }
    
    @objc private func handleRefresh() {
        Task {
            await viewModel.getAdvertisements()
            tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
}

extension AdvertisementListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        viewModel.advertisements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AdvertisementCell.reuseIdentifier,
                for: indexPath
            ) as? AdvertisementCell
        else {
            return UITableViewCell()
        }
        let ad = viewModel.advertisements[indexPath.row]
        cell.configure(with: ad)
        
        cell.onFavoriteTapped = { [weak self] in
            guard let self = self else { return }
            let ad = self.viewModel.advertisements[indexPath.row]
            self.viewModel.toggleFavorite(advertisement: ad)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
}

extension AdvertisementListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let ad = viewModel.advertisements[indexPath.row]
        let detailViewController = AdvertisementDetailViewController(
            viewModel: AdvertisementDetailViewModel(advertisementId: ad.id)
        )
        navigationController?.pushViewController(
            detailViewController,
            animated: true
        )
    }
}
