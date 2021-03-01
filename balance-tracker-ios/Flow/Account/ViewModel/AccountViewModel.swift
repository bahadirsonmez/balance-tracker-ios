//
//  AccountViewModel.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 20.02.2021.
//
import Foundation

class AccountViewModel: NSObject {
    let manager: AccountAPIManager

    init(manager: AccountAPIManager) {
        self.manager = manager
        super.init()
    }
}
