//
//  ProfileViewModel.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 20.02.2021.
//
import Foundation

class ProfileViewModel: NSObject {
    let manager: ProfileAPIManager

    init(manager: ProfileAPIManager) {
        self.manager = manager
        super.init()
    }
}
