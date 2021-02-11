//
//  UITableView+Extension.swift
//  CryptoTicker
//
//  Created by Yusuf Demirci on 10.02.21.
//

import UIKit

extension UITableView {

    func deselectAllSelectedRows() {
        let _ = self.indexPathsForSelectedRows?.compactMap { self.deselectRow(at: $0, animated: true) }
    }
}
