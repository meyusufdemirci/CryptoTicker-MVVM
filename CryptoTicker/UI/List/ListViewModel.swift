//
//  ListViewModel.swift
//  CryptoTicker
//
//  Created by Yusuf Demirci on 08.02.21.
//

import RxCocoa
import RxSwift

class ListViewModel {

    // MARK: Properties

    let coins: BehaviorRelay<[Coin]> = .init(value: [])

    func refreshCoins() {
        coins.accept(getDummyCoins())
    }

    func search(_ text: String?) {
        if let text = text, !text.isEmpty {
            coins.accept(getDummyCoins().filter { $0.symbol.lowercased().contains(text.lowercased()) })
        } else {
            coins.accept(getDummyCoins())
        }
    }
}

private extension ListViewModel {

    func getDummyCoins() -> [Coin] {
        [
            .init(symbol: "BTCUSDT", price: 42500),
            .init(symbol: "ETHUSDT", price: 1500),
            .init(symbol: "XRPUSDT", price: 0.5),
            .init(symbol: "LTCUSDT", price: 175)
        ]
    }
}
