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
        coins = [ .init(symbol: "BTCUSDT", price: 42500) ]
        
        delegate?.coinsDidRefreshSuccessfully()
    }
}
