# CryptoTicker
Simple MVVM example project with protocol, closure and, reactive programming(RxSwift) scenarios.

The project has 2 simple screens which are list and coin. In the list, can be seen the coins in a list and searched for them. 
In the coin, the coin model is passed from the list to here and is showed its symbol in the navigation bar title.

<a href="https://ibb.co/djmFqJ0"><img src="https://i.ibb.co/QpDLRjF/1.png" alt="List" width="25%" height="25%"></a>
<a href="https://ibb.co/25qFXkc"><img src="https://i.ibb.co/SJN6q3V/2.png" alt="Search" width="25%" height="25%"></a>
<a href="https://ibb.co/16XGMS7"><img src="https://i.ibb.co/rsp23WF/3.png" alt="Coin" width="25%" height="25%"></a>

Please change the branches to see the scenarios.

## Protocol
The controller and view model communicates with protocol functions

**View Model**
```
protocol ListDelegate {
    func coinsDidRefresh()
}

func refreshCoins() {
    delegate?.coinsDidRefresh()
}
```
**Controller**
```
func coinsDidRefresh() {
    tableView.reloadData()
}
```

## Closure
The controller and view model communicates with closures

**View Model**
```
var coinsDidRefresh: (() -> Void)?

func refreshCoins() {
    coinsDidRefresh?()
}
```
**Controller**
```
viewModel.coinsDidRefresh = { [weak self] in
    self?.tableView.reloadData()
}
```

## Reactive
The controller and view model communicates with reactive programming

**View Model**
```
let coins: BehaviorRelay<[Coin]> = .init(value: [])

func refreshCoins() {
    coins.accept(getDummyCoins())
}
```
**Controller**
```
viewModel.coins.bind(to: tableView.rx.items(cellIdentifier: "ListCell", cellType: UITableViewCell.self)) { index, model, cell in
    cell.textLabel?.text = model.symbol
    cell.detailTextLabel?.text = "\(model.price)"
}.disposed(by: disposeBag)
```
