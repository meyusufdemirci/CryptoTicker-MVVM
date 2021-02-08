//
//  ListController.swift
//  CryptoTicker
//
//  Created by Yusuf Demirci on 08.02.21.
//

import UIKit

class ListController: UITableViewController {

    // MARK: Properties

    private let viewModel: ListViewModel

    init(viewModel: ListViewModel = ListViewModel()) {
        self.viewModel = viewModel

        super.init(style: .grouped)

        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    }
}

// MARK: - ListDelegate

extension ListController: ListDelegate {

    func coinsDidRefreshSuccessfully() {
        tableView.reloadData()
    }

    func coinsDidRefreshUnsuccessfully() {
        // An error occured
    }
}
