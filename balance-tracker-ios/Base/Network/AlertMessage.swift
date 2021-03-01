//
//  AlertMessage.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import Foundation

class AlertMessage: Error {

    // MARK: - Vars & Lets

    var title = ""
    var body = ""

    // MARK: - Intialization

    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
