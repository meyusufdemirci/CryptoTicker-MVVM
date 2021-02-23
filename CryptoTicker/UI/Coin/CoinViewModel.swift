//
//  CoinViewModel.swift
//  CryptoTicker
//
//  Created by Yusuf Demirci on 09.02.21.
//

import RxCocoa
import RxSwift

class CoinViewModel {

    // MARK: Properties

    let coin: BehaviorRelay<Coin>

    init(coin: Coin) {
        self.coin = .init(value: coin)
    }
}
