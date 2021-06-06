//
//  FriendModel.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 20.02.2021.
//
import Foundation

struct FriendList: Codable {
    let friends: [FriendItem]?
}

struct FriendItem: Codable {
    let id: String?
    let name: String?
    let image: String?
    let apiKey: String?
    let secretKey: String?
}

struct DummyFriends {
    let friends: FriendList

    init() {
        friends = FriendList(friends: [
            FriendItem(id: "0", name: "Yağmur", image: "", apiKey: KeychainAccount.sharedAccount.apiKey, secretKey:KeychainAccount.sharedAccount.secretKey),
            FriendItem(id: "1", name: "Görkem", image: "", apiKey: KeychainAccount.sharedAccount.apiKey, secretKey: KeychainAccount.sharedAccount.secretKey),
            FriendItem(id: "2", name: "Barış", image: "", apiKey: KeychainAccount.sharedAccount.apiKey, secretKey: KeychainAccount.sharedAccount.secretKey),
            FriendItem(id: "3", name: "Birtan", image: "", apiKey: KeychainAccount.sharedAccount.apiKey, secretKey: KeychainAccount.sharedAccount.secretKey),
            FriendItem(id: "4", name: "Müdür", image: "", apiKey: KeychainAccount.sharedAccount.apiKey, secretKey: KeychainAccount.sharedAccount.secretKey),
        ])
    }
}
