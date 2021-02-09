//
//  CoinController.swift
//  CryptoTicker
//
//  Created by Yusuf Demirci on 09.02.21.
//

import UIKit

class CoinController: UIViewController {

    // MARK: Properties

    private let viewModel: CoinViewModel

    init(viewModel: CoinViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        title = viewModel.coin.symbol
    }
}
