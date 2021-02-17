//
//  String+localized.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 18.02.2021.
//
import Foundation

extension String {
    func localized(with comment: String = "") -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }

    func localized(with comment: String = "", value: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: value, comment: comment)
    }
}
