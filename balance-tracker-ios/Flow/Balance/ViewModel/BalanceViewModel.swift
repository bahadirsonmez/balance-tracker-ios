//
//  BalanceViewModel.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import Foundation

class BalanceViewModel: NSObject {
    let manager: BalanceAPIManager
    let binance: BinanceAPI

    var isLoading: ((Bool) -> ())?

    //    var items: Balance?
    var binanceAccount: Account?
    var binanceBalances = [AccountBalance]()
    var binanceBalancesWithTickerPrice = [AccountBalanceWithTickerPriceChange]()
    var prices = [TickerPriceChange]()
    var btcPrice = 0.0
    
    //    var balanceList = [BalanceItem]()
    //    var balanceDetail: BalanceItem?

    init(manager: BalanceAPIManager, binance: BinanceAPI) {
        self.manager = manager
        self.binance = binance
        super.init()
    }

    func getData(success: @escaping () -> Void,
                 failure: @escaping (Error) -> Void) {
        self.isLoading?(true)
        binance.account { (account) in
            self.isLoading?(false)
            var list = [AccountBalance]()
            account.balances.forEach { (balance) in
                if balance.asset.hasSuffix("UP") || balance.asset == "TRY" || balance.asset == "USDT" {
                    return
                }
                if balance.totalAmount > 0.0 {
                    list.append(balance)
                }
            }
            self.binanceAccount = account
            self.binanceBalances = list
            self.getAllPrices()
            success()
        } failure: { (error) in
            self.isLoading?(false)
            failure(error)
        }
    }

    private func getAllPrices() {
        self.binanceBalances.forEach { (balance) in
            var endString: String
            if balance.asset == "BTC" {
                endString = "USDT"
            } else {
                endString = "BTC"
            }
            binance.tickerChange(symbol: "\(balance.asset)\(endString)") { (priceChange) in
                let balanceWithTickerPrice = AccountBalanceWithTickerPriceChange(
                    accountBalance: balance,
                    tickerPriceChange: priceChange
                )
                self.binanceBalancesWithTickerPrice.append(balanceWithTickerPrice)
            } failure: { (err) in
                print(err)
            }
        }
    }


    var numberOfItems: Int {
        //        guard let count = self.binanceBalances.count else { return 0 }
        return self.binanceBalances.count
    }
}
