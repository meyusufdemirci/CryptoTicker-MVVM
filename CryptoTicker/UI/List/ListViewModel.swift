//
//  ListViewModel.swift
//  CryptoTicker
//
//  Created by Yusuf Demirci on 08.02.21.
//

import Foundation

protocol ListDelegate {
    func coinsDidRefreshSuccessfully()
    func coinsDidRefreshUnsuccessfully()
}

class ListViewModel {

    // MARK: Properties

    var coins: [Coin] = []

    var delegate: ListDelegate?

    func refreshCoins() {
        coins = getDummyCoins()
        
        delegate?.coinsDidRefreshSuccessfully()
    }

    func search(_ text: String?) {
        if let text = text, !text.isEmpty {
            coins = getDummyCoins().filter { $0.symbol.lowercased().contains(text.lowercased()) }
        } else {
            coins = getDummyCoins()
        }

        delegate?.coinsDidRefreshSuccessfully()
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
