//
//  CoinController.swift
//  CryptoTicker
//
//  Created by Yusuf Demirci on 09.02.21.
//

import RxSwift
import UIKit

class CoinController: UIViewController {

    // MARK: Properties

    private let viewModel: CoinViewModel

    private let disposeBag: DisposeBag = .init()

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

        viewModel.coin.subscribe(onNext: { coin in
            self.title = coin.symbol
        })
        .disposed(by: disposeBag)
    }
}
