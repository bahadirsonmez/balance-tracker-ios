//
//  Coordinator.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//

import Foundation

protocol Coordinator: class {
    func start()
    func start(with option: DeepLinkOption?)
}
