//
//  String+extension.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 18.02.2021.
//
import Foundation
import CryptoSwift

extension String {
    func localized(with comment: String = "") -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }

    func localized(with comment: String = "", value: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: value, comment: comment)
    }
}

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }

    func remotePlus() -> String {
        return self.replace(string: "+", replacement: "")
    }
}

// MARK: - For binance API
extension String {

    func hmac(secret: String, variant: HMAC.Variant = .sha256) -> String? {
        do {
            let hmac = try HMAC(key: secret, variant: variant)
            let result = try hmac.authenticate([UInt8](self.utf8))
            let hex = result.map { String(format: "%02x", $0) }.joined()
            return hex
        } catch {
            print(error)
        }

        return nil
    }
}

extension String {
    func toDouble() -> Double {
        guard let doubleValue = Double(self) else { return 0.0 }
        return doubleValue
    }
}

