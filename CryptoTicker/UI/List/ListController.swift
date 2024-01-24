//
//  ListController.swift
//  CryptoTicker
//
//  Created by Yusuf Demirci on 08.02.21.
//

import UIKit
import Combine

class ListController: UITableViewController {

    // MARK: Properties

    private let searchController: UISearchController = {
        let controller: UISearchController = UISearchController()
        controller.searchBar.placeholder = "Search"
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }()

    private let viewModel: ListViewModel
    private var subscribers: Set<AnyCancellable> = []

    init(viewModel: ListViewModel = ListViewModel()) {
        self.viewModel = viewModel

        super.init(style: .grouped)

        self.viewModel.$coins
            .sink { coins in
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }.store(in: &subscribers)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController

        searchController.searchResultsUpdater = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.refreshCoins()
    }
}

// MARK: - TableView

extension ListController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coin = viewModel.coins[indexPath.row]

        let cell = UITableViewCell(style: .value1, reuseIdentifier: "\(indexPath.section)_\(indexPath.row)")

        cell.textLabel?.text = coin.symbol
        cell.detailTextLabel?.text = "\(coin.price)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let coin = viewModel.coins[indexPath.row]

        let coinViewModel = CoinViewModel(coin: coin)
        let coinController = CoinController(viewModel: coinViewModel)

        navigationController?.show(coinController, sender: self)
    }
}

// MARK: - UISearchResultsUpdating

extension ListController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        viewModel.search(searchController.searchBar.text)
    }
}
