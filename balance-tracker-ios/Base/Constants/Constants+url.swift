//
//  Constants+url.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import UIKit

extension Constants {
    static let appGroup: String = UIApplication.appGroup ?? ""
    static let baseURL: String = ""
    static let webURL: String = ""
    static let loginURL: String = ""
    static let registerURL: String = UIApplication.registerURL ?? "default"
    static let socketURL: String = UIApplication.socketURL ?? "default"
    static let searchURL: String = UIApplication.searchURL ?? "default"
    static let paymentURL: String = UIApplication.paymentURL ?? "default"
    static let paymentAuth: String = UIApplication.paymentAuth ?? "default"
    static let notificationURL: String = UIApplication.notificationURL ?? "default"
    static let insiderPartnerName: String = UIApplication.insiderPartnerName ?? "default"
    static let appVersion: String = UIApplication.appVersion ?? "default"

    static let prodBase: String = ""
    static let devBase: String = ""
    static let constactTR: String = "https://api.sky.hamurlabs.com/v1/contact_us/?lang=tr"
    static let contactEN: String = "https://api.sky.hamurlabs.com/v1/contact_us/?lang=en"
}

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "APP_VERSION") as? String
    }
    static var appGroup: String? {
        return Bundle.main.object(forInfoDictionaryKey: "APP_GROUP") as? String
    }
    static var baseURL: String? {
        return Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String
    }
    static var loginURL: String? {
        return Bundle.main.object(forInfoDictionaryKey: "LOGIN_URL") as? String
    }
    static var registerURL: String? {
        return Bundle.main.object(forInfoDictionaryKey: "REGISTER_URL") as? String
    }
    static var socketURL: String? {
        return Bundle.main.object(forInfoDictionaryKey: "SOCKET_URL") as? String
    }
    static var searchURL: String? {
        return Bundle.main.object(forInfoDictionaryKey: "SEARCH_URL") as? String
    }
    static var paymentURL: String? {
        return Bundle.main.object(forInfoDictionaryKey: "PAYMENT_URL") as? String
    }
    static var paymentAuth: String? {
        return Bundle.main.object(forInfoDictionaryKey: "PAYMENT_AUTH") as? String
    }
    static var notificationURL: String? {
        return Bundle.main.object(forInfoDictionaryKey: "NOTIFICATION_URL") as? String
    }
    static var insiderPartnerName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "INSIDER_PARTNER_NAME") as? String
    }
}
