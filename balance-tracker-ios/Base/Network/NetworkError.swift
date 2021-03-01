//
//  NetworkError.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import Foundation

class NetworkError: Codable {
    let message: String
    let key: String?
}
