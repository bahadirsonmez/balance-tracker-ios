//
//  CoinPrices.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 6.06.2021.
//
import Foundation

// MARK: - CoinPrices
struct CoinPrices: Codable {
    let status: String?
    let data: DataClass?

    enum CodingKeys: String, CodingKey {
        case status, data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent(DataClass.self, forKey: .data)
    }

}

// MARK: - DataClass
struct DataClass: Codable {
    let coins: [Coin]?

    enum CodingKeys: String, CodingKey {
        case coins
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coins = try values.decodeIfPresent([Coin].self, forKey: .coins)
    }

}

// MARK: - Coin
struct Coin: Codable {
    let uuid, symbol, price: String?

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, price
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        price = try values.decodeIfPresent(String.self, forKey: .price)
    }
}
