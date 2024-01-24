# CryptoTicker
Simple MVVM example project with protocol, closure, reactive programming(RxSwift), and comebine scenarios.

If you would like to understand the idea behind it, you can read the article about the project in [Medium](https://demirciy.medium.com/mvvm-in-ios-development-with-protocol-closure-reactive-programming-rxswift-d0933b235235).

The project has 2 simple screens which are list and coin. In the list, can be seen the coins in a list and searched for them. 
In the coin, the coin model is passed from the list to here and is showed its symbol in the navigation bar title.

<a href="https://ibb.co/djmFqJ0"><img src="https://i.ibb.co/QpDLRjF/1.png" alt="List" width="25%" height="25%"></a>
<a href="https://ibb.co/25qFXkc"><img src="https://i.ibb.co/SJN6q3V/2.png" alt="Search" width="25%" height="25%"></a>
<a href="https://ibb.co/16XGMS7"><img src="https://i.ibb.co/rsp23WF/3.png" alt="Coin" width="25%" height="25%"></a>

Please change the branches to see the scenarios.

## Protocol
The controller and view model communicates with protocol functions

**View Model**
```swift
protocol ListDelegate {
    func coinsDidRefresh()
}

func refreshCoins() {
    delegate?.coinsDidRefresh()
}
```
**Controller**
```swift
func coinsDidRefresh() {
    tableView.reloadData()
}
```

## Closure
The controller and view model communicates with closures

**View Model**
```swift
var coinsDidRefresh: (() -> Void)?

func refreshCoins() {
    coinsDidRefresh?()
}
```
**Controller**
```swift
viewModel.coinsDidRefresh = { _ in
    tableView.reloadData()
}
```

## Reactive
The controller and view model communicates with reactive programming

**View Model**
```swift
let coins: BehaviorRelay<[Coin]> = .init(value: [])

func refreshCoins() {
    coins.accept(getDummyCoins())
}
```
**Controller**
```swift
viewModel.coins.bind(to: tableView.rx.items(cellIdentifier: "ListCell", cellType: UITableViewCell.self)) { index, model, cell in
    cell.textLabel?.text = model.symbol
    cell.detailTextLabel?.text = "\(model.price)"
}
.disposed(by: disposeBag)
```

## Combine
The controller and view model communicates with Combine framework

**View Model**
```swift
@Published var coins: [Coin] = []

func refreshCoins() {
    coins = getDummyCoins()
}
```

**Controller**
```swift
viewModel.$coins
    .sink { coins in
        tableView.reloadData()
    }
    .store(in: &subscribers)
```
