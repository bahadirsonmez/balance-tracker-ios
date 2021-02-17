//
//  Account+Keychain.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
import KeychainAccess

public class Account {
    public let AnonymousAccountKeychainService = "AnonymousAccountKeychainService"
    public let AnonymousAccountAccessTokenKeychainKey = "anonymous_access_token"

    public let AccountKeychainService = "UserAccountKeychainService"
    public let AccountAccessTokenKeychainKey = "access_token"
    public let AccountRefreshTokenKeychainKey = "refresh_token"
    public let UserAgreementKeychainKey = "user_agreement"

    public let rentStateKey = "rent_state"

    public let uuidService = "uuid_service"
    public let uuidKey = "com.hamurlabs.sky-ios.unique_uuid"

    public let xDeviceService = "xdevice_service"
    public let xDeviceKey = "com.hamurlabs.sky-ios.unique_xdevice"

    public let FCMTokenKeychainService = "FCMTokenKeychainService"
    public let FCMTokenKeychainKey = "fcm_token"

    public static let sharedAccount = Account()

    public var isLoggedin: Bool? {
        if accessToken != nil {
            return true
        }else {
            return false
        }
    }

    public var deviceId: String? {
        get {
            let keychain = Keychain(service: uuidService)
            do {
                let deviceId = try keychain.get(uuidKey)
                return deviceId
            } catch {
                return nil
            }
        }
    }

    public func setDeviceId(_ deviceId: String?) {
        let keychain = Keychain(service: uuidService)
        if let deviceId = deviceId {
            do {
                try keychain.set(deviceId, key: uuidKey)
                print("set deviceId")
                print(deviceId)
            } catch {
                print("failed to set deviceId")
            }
        } else {
            do {
                try keychain.remove(uuidKey)
                print("removed deviceId")
            } catch {
                print("failed to remove deviceId")
            }
        }
    }

    public func clearDeviceId(){
        let keychain = Keychain(service: uuidService)
        let deviceId = self.deviceId
        if deviceId != nil {
            do {
                try keychain.remove(uuidKey)
                print("deviceId removed")
            } catch {
                print("failed to remove deviceId")
            }
        }
    }

    public var xDeviceId: String? {
        get {
            let keychain = Keychain(service: xDeviceService)
            do {
                let deviceId = try keychain.get(xDeviceKey)
                return deviceId
            } catch {
                return nil
            }
        }
    }

    public func setXDeviceId(_ xDeviceId: String?) {
        let keychain = Keychain(service: xDeviceService)
        if let xDeviceId = xDeviceId {
            do {
                try keychain.set(xDeviceId, key: xDeviceKey)
                print("set xDeviceId")
                print(xDeviceId)
            } catch {
                print("failed to set xDeviceId")
            }
        } else {
            do {
                try keychain.remove(xDeviceKey)
                print("removed xDeviceId")
            } catch {
                print("failed to remove xDeviceId")
            }
        }
    }

    public func clearXDeviceId(){
        let keychain = Keychain(service: xDeviceService)
        let xDeviceId = self.xDeviceId
        if xDeviceId != nil {
            do {
                try keychain.remove(xDeviceKey)
                print("xDeviceId removed")
            } catch {
                print("failed to remove xDeviceId")
            }
        }
    }

    public var fcmToken: String? {
        get {
            let keychain = Keychain(service: FCMTokenKeychainService)
            do {
                let token = try keychain.get(FCMTokenKeychainKey)
                return token
            } catch {
                return nil
            }
        }
    }

    public func setFCMToken(_ token: String?) {
        let keychain = Keychain(service: FCMTokenKeychainService)
        if let token = token {
            do {
                try keychain.set(token, key: FCMTokenKeychainKey)
                print("set fcm token")
                print(token)
            } catch {
                print("failed to set fcm token")
            }
        } else {
            do {
                try keychain.remove(FCMTokenKeychainKey)
                print("removed fcm token")
            } catch {
                print("failed to remove fcm token")
            }
        }
    }

    public func clearFCMToken(){
        let keychain = Keychain(service: FCMTokenKeychainService)
        let token = self.fcmToken
        if token != nil {
            do {
                try keychain.remove(FCMTokenKeychainKey)
                print("fcm token removed")
            } catch {
                print("failed to remove fcm token")
            }
        }
    }

    public var accessToken: String? {
        get {
            let keychain = Keychain(service: AccountKeychainService)
            do {
                let token = try keychain.get(AccountAccessTokenKeychainKey)
                return token
            } catch {
                return nil
            }
        }
    }

    public var isLoggedIn: Bool {
        get {
            if Account.sharedAccount.accessToken == nil {
                return false
            }else {
                return true
            }
        }
    }

    public func setAccessToken(_ token: String?) {
        let keychain = Keychain(service: AccountKeychainService)
        if let token = token {
            do {
                try keychain.set(token, key: AccountAccessTokenKeychainKey)
                print("set access token")
                print(token)
            } catch {
                print("failed to set access token")
            }
        } else {
            do {
                try keychain.remove(AccountAccessTokenKeychainKey)
                print("removed access token")
            } catch {
                print("failed to remove access token")
            }
        }
    }

    public func clearAccessToken(){
        let keychain = Keychain(service: AccountKeychainService)
        let token = self.accessToken
        if token != nil {
            do {
                try keychain.remove(AccountAccessTokenKeychainKey)
                print("access token removed")
            } catch {
                print("failed to remove access token")
            }
        }
    }

    public var refreshToken: String? {
        get {
            let keychain = Keychain(service: AccountKeychainService)
            do {
                let token = try keychain.get(AccountRefreshTokenKeychainKey)
                return token
            } catch {
                return nil
            }
        }
    }

    public func setRefreshToken(_ token: String?) {
        let keychain = Keychain(service: AccountKeychainService)
        if let token = token {
            do {
                try keychain.set(token, key: AccountRefreshTokenKeychainKey)
                print("set access token")
                print(token)
            } catch {
                print("failed to set access token")
            }
        } else {
            do {
                try keychain.remove(AccountRefreshTokenKeychainKey)
                print("removed access token")
            } catch {
                print("failed to remove access token")
            }
        }
    }

    public func clearRefreshToken(){
        let keychain = Keychain(service: AccountKeychainService)
        let token = self.refreshToken
        if token != nil {
            do {
                try keychain.remove(AccountRefreshTokenKeychainKey)
                print("access token removed")
            } catch {
                print("failed to remove access token")
            }
        }
    }



    public var anynomousToken: String? {
        get {
            let keychain = Keychain(service: AnonymousAccountKeychainService)
            do {
                let token = try keychain.get(AnonymousAccountAccessTokenKeychainKey)
                return token
            } catch {
                return nil
            }
        }
    }

    public func setAnynomousToken(_ token: String?) {
        let keychain = Keychain(service: AnonymousAccountKeychainService)
        if let token = token {
            do {
                try keychain.set(token, key: AnonymousAccountAccessTokenKeychainKey)
                print("set access Anynomous token")
                print(token)
            } catch {
                print("failed to set Anynomous access token")
            }
        } else {
            do {
                try keychain.remove(AnonymousAccountAccessTokenKeychainKey)
                print("removed access Anynomous token")
            } catch {
                print("failed to remove Anynomous access token")
            }
        }
    }

    public func clearAnynomousToken(){
        let keychain = Keychain(service: AnonymousAccountKeychainService)
        let token = self.anynomousToken
        if token != nil {
            do {
                try keychain.remove(AnonymousAccountAccessTokenKeychainKey)
                print("access token removed")
            } catch {
                print("failed to remove access token")
            }
        }
    }

    public var userAgreement: String? {
        get {
            let keychain = Keychain(service: AccountKeychainService)
            do {
                let key = try keychain.get(UserAgreementKeychainKey)
                return key
            } catch {
                return nil
            }
        }
    }

    public func setUserAgreement (_ isSet: String?) {
        let keychain = Keychain(service: AccountKeychainService)
        if let isSet = isSet {
            do {
                try keychain.set(isSet, key: UserAgreementKeychainKey)
                print("set access isSet")
                print(isSet)
            } catch {
                print("failed to set access isSet")
            }
        } else {
            do {
                try keychain.remove(UserAgreementKeychainKey)
                print("removed access isSet")
            } catch {
                print("failed to remove access isSet")
            }
        }
    }

    public func clearUserAgreement(){
        let keychain = Keychain(service: AccountKeychainService)
        let isSet = self.userAgreement
        if isSet != nil {
            do {
                try keychain.remove(UserAgreementKeychainKey)
                print("isSet removed")
            } catch {
                print("failed to remove access isSet")
            }
        }
    }

    public func clearAll() {
        clearAccessToken()
        clearRefreshToken()
        clearUserAgreement()
        clearAnynomousToken()
        //UserDefaultHelper.deletaAll()
    }
}
