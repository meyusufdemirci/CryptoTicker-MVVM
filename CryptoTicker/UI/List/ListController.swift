//
//  ListController.swift
//  CryptoTicker
//
//  Created by Yusuf Demirci on 08.02.21.
//

import UIKit
import RxSwift
import RxCocoa

class ListController: UITableViewController {

    // MARK: Properties

    private let searchController: UISearchController = {
        let controller: UISearchController = UISearchController()
        controller.searchBar.placeholder = "Search"
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }()

    private let viewModel: ListViewModel

    private let disposeBag = DisposeBag()

    init(viewModel: ListViewModel = ListViewModel()) {
        self.viewModel = viewModel

        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController

        // IGNORE: This is just for running RxSwift with UITableViewController
        tableView.dataSource = nil

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ListCell")

        // Cell displaying
        viewModel.coins
            .bind(to: tableView.rx.items(cellIdentifier: "ListCell", cellType: UITableViewCell.self)) { index, model, cell in
                cell.textLabel?.text = model.symbol
                cell.detailTextLabel?.text = "\(model.price)"
            }
            .disposed(by: disposeBag)

        // Row selection
        tableView.rx
            .modelSelected(Coin.self)
            .subscribe(onNext: { coin in
                self.tableView.deselectAllSelectedRows()

                let coinViewModel = CoinViewModel(coin: coin)
                let coinController = CoinController(viewModel: coinViewModel)

                self.navigationController?.show(coinController, sender: self)
            })
            .disposed(by: disposeBag)

        // Search
        searchController.searchBar.rx.text
            .orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { (text) in
                self.viewModel.search(text)
            })
            .disposed(by: disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.refreshCoins()
    }
}
