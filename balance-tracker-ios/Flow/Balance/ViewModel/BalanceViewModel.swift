//
//  BalanceViewModel.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import Foundation

class BalanceViewModel: NSObject {
    let manager: BalanceAPIManager
    var binance: BinanceAPI!

    var isLoading: ((Bool) -> ())?

    //    var items: Balance?
    var binanceAccount: Account?
    var binanceBalances = [AccountBalance]()
    var binanceBalancesWithTickerPrice = [AccountBalanceWithTickerPriceChange]()
    var prices: CoinPrices?
    var btcPrice = 0.0
    
    //    var balanceList = [BalanceItem]()
    //    var balanceDetail: BalanceItem?

    init(manager: BalanceAPIManager) {
        self.manager = manager
        super.init()
    }

    func getData(success: @escaping () -> Void,
                 failure: @escaping (Error) -> Void) {
        self.binance = BinanceAPI(key: KeychainAccount.sharedAccount.apiKey!, secret: KeychainAccount.sharedAccount.secretKey!)
        self.isLoading?(true)
        binance.account { (account) in
            self.isLoading?(false)
            var list = [AccountBalance]()
            account.balances.forEach { (balance) in
                if balance.asset == "TRY" ||
                    balance.asset == "USDT" ||
                    balance.asset.hasPrefix("LD") {
                    return
                }
                if balance.totalAmount > 0.0 {
                    list.append(balance)
                }
            }
            self.binanceAccount = account
            self.binanceBalances = list
            success()
        } failure: { (error) in
            self.isLoading?(false)
            failure(error)
        }
    }

    func getAllPrices(success: @escaping () -> Void,
                      failure: @escaping (Error) -> Void) {
        self.manager.call(router: BalanceRouter.getCoinPrices) { (data, error) in
            if error != nil {
                guard let error = error else { return }
                print(error.localizedDescription)
                failure(error)
            } else {
                self.prices = data
                self.addPriceInfoToTheList()
                success()
//                print(self.prices)
            }
        }
    }

    private func addPriceInfoToTheList() {
        guard let coins = prices?.data?.coins else { return }
        for i in binanceBalances.indices {
            for y in coins.indices {
                if binanceBalances[i].asset == coins[y].symbol! {
                    binanceBalances[i].coinPrice = coins[y].price ?? "0.0"
                }
            }
        }
    }

    var numberOfItems: Int {
        return self.binanceBalances.count
    }
}

