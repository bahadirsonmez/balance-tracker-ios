//
//  FriendsViewModel.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 20.02.2021.
//
import Foundation

class FriendsViewModel: NSObject {
    let manager: FriendsAPIManager!
    var friends = DummyFriends.init().friends.friends

    var isLoading: ((Bool) -> ())?

    var binanceAPI: BinanceAPI!
    var binanceAccount: Account?
    var binanceBalances = [AccountBalance]()

    init(manager: FriendsAPIManager) {
        self.manager = manager
        super.init()
    }

    var numberOfFriends: Int {
        return friends?.count ?? 0
    }

    var friendItems: [FriendItem] {
        return friends ?? []
    }

    var numberOfItems: Int {
        return self.binanceBalances.count
    }

    func getSelectedFriend(index: Int) -> FriendItem? {
        return friends?[index]
    }


    func getFriendBalanceDetail(_ item: FriendItem, success: @escaping () -> Void,
                 failure: @escaping (Error) -> Void) {
        self.binanceAPI = BinanceAPI(key: item.apiKey ?? "-1", secret: item.secretKey ?? "-1")
        self.isLoading?(true)
        binanceAPI.account { (account) in
            self.isLoading?(false)
            var list = [AccountBalance]()
            account.balances.forEach { (balance) in
                if balance.asset == "TRY" || balance.asset == "USDT" {
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
}
