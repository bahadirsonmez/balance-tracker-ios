//
//  BinanceAPI.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 27.02.2021.
//

import Foundation
import CryptoSwift

public struct TickerPriceChange: Codable {
    public var symbol: String
    public var priceChange: String
    public var priceChangePercent: String
    public var weightedAvgPrice: String
    public var prevClosePrice: String
    public var lastPrice: String
    public var lastQty: String
    public var bidPrice: String
    public var askPrice: String
    public var openPrice: String
    public var highPrice: String
    public var lowPrice: String
    public var volume: String
    public var quoteVolume: String
    public var openTime: Int
    public var closeTime: Int
    public var firstId: Int
    public var lastId: Int
    public var count: Int
}

public struct Account: Codable {
    public var makerCommission: Int
    public var takerCommission: Int
    public var buyerCommission: Int
    public var sellerCommission: Int
    public var canTrade: Bool
    public var canWithdraw: Bool
    public var canDeposit: Bool
    public var updateTime: Int
    public var balances: [AccountBalance]

    public var totalAmount: Double {
        var total = 0.0
        balances.forEach { (balance) in
            total += balance.totalAmount
        }
        return total
    }
}

public struct AccountBalance: Codable {
    public var asset: String
    public var free: String
    public var locked: String
    public var coinPrice: String?

    public var totalAmount: Double {
        return free.toDouble() + locked.toDouble()
    }

    public var totalPrice: Double {
        return (Double(coinPrice ?? "0.0") ?? 0.0) * totalAmount
    }
}

public struct AccountBalanceWithTickerPriceChange: Codable {
    public var accountBalance: AccountBalance
    public var tickerPriceChange: TickerPriceChange?

    public var totalDollars: Double {
        return accountBalance.totalAmount * lastPrice
    }

    public var lastPrice: Double {
        return tickerPriceChange?.lastPrice.toDouble() ?? 1.0
    }

    public var priceChangePercent: Double {
        return tickerPriceChange?.priceChangePercent.toDouble() ?? 0.0
    }
}

public typealias SuccessCallbackEmpty = () -> Void
public typealias SuccessCallback<T: Codable> = (T) -> Void
public typealias FailureCallback = (Error) -> Void

public enum BinanceAPIError: Error {
    case unexpectedResponseCode(Int)
    case invalidResponse(Data)
}

public enum RequestMethod: String {
    case get = "GET", post = "POST", delete = "DELETE"
}

public class BinanceAPI {

    private let baseUrl = "https://api.binance.com/api/"
    private var key: String
    private var secret: String
    private var decoder = JSONDecoder()

    public init(key: String, secret: String) {
        self.key = key
        self.secret = secret
    }

    class var timestamp: Int {
        let nonce = Int(Date().timeIntervalSince1970 * 1000)
        return nonce
    }

    private func calculateSignature(params: [String: Any]) -> String? {
        let queryString = params.sorted { $0.0 < $1.0 }.map { "\($0.0)=\($0.1)"}.joined(separator: "&")
        return queryString.hmac(secret: self.secret)
    }

    private func request(for endpoint: String, params: [String: Any]) -> URLRequest? {
        let queryString = params.sorted { $0.0 < $1.0 }.map { "\($0.0)=\($0.1)"}.joined(separator: "&")
        let urlStr = self.baseUrl + endpoint + (params.count > 0 ? "?" + queryString : "")
        guard let url = URL(string: urlStr) else { return nil }
        var request = URLRequest(url: url)
        request.addValue(self.key, forHTTPHeaderField: "X-MBX-APIKEY")
        return request
    }

    private func signedRequest(for endpoint: String, method: RequestMethod, params: [String: Any]) -> URLRequest? {
        var params = params
        params["timestamp"] = BinanceAPI.timestamp
        var queryString = params.sorted { $0.0 < $1.0 }.map { "\($0.0)=\($0.1)"}.joined(separator: "&")
        guard let signature = self.calculateSignature(params: params) else { return nil }
        queryString += "&signature=\(signature)"
        let urlStr = self.baseUrl + endpoint + (method == .get ? "?\(queryString)" : "")
        guard let url = URL(string: urlStr) else { return nil }
        print(#function, #line, "⇨", url)
        print(#function, #line, "⇨", queryString)
        var request = URLRequest(url: url)
        request.addValue(self.key, forHTTPHeaderField: "X-MBX-APIKEY")
        request.httpMethod = method.rawValue
        switch method {
        case .post, .delete:
            request.httpBody = queryString.data(using: .utf8)
        default:
            break
        }
        return request
    }

    private func runRequest<T: Codable>(request: URLRequest, success: SuccessCallback<T>? = nil, failure: FailureCallback? = nil) {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                print(#function, #line, "⇨", String(data: data, encoding: .utf8))
                print(#function, #line, "⇨", (response as? HTTPURLResponse)?.statusCode)
                do {
                    let obj = try self.decoder.decode(T.self, from: data)
                    success?(obj)
                } catch let err {
                    print(#function, err)
                    failure?(err)
                }
            }.resume()
    }

    private func runRequest(request: URLRequest, success: SuccessCallbackEmpty? = nil, failure: FailureCallback? = nil) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                print(#function, #line, "⇨", String(data: data, encoding: .utf8))
            }
            print(#function, #line, "⇨", (response as? HTTPURLResponse)?.statusCode)
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {
                success?()
            } else {
                failure?(BinanceAPIError.unexpectedResponseCode(response.statusCode))
            }
        }.resume()
    }

    public func ping(success: SuccessCallbackEmpty? = nil, failure: FailureCallback? = nil) {
        guard let request = self.request(for: "v3/ping", params: [:]) else { return }
        runRequest(request: request, success: success, failure: failure)
    }

    public func tickerChange(symbol: String, success: SuccessCallback<TickerPriceChange>? = nil, failure: FailureCallback? = nil) {
        let params: [String: Any] = ["symbol": symbol]
        guard let request = self.request(for: "v3/ticker/24hr", params: params) else { return }
        runRequest(request: request, success: success, failure: failure)
    }

    public func tickerChange(success: SuccessCallback<[TickerPriceChange]>? = nil, failure: FailureCallback? = nil) {
        let params: [String: Any] = [:]
        guard let request = self.request(for: "v3/ticker/24hr", params: params) else { return }
        runRequest(request: request, success: success, failure: failure)
    }

    public func account(success: SuccessCallback<Account>? = nil, failure: FailureCallback? = nil) {
        guard let request = self.signedRequest(for: "v3/account", method: .get, params: [:]) else { return }
        runRequest(request: request, success: success, failure: failure)
    }

//    public func account(symbol: String, limit: Int, success: SuccessCallback<[MyTrade]>? = nil, failure: FailureCallback? = nil) {
//        guard let request = self.signedRequest(for: "v3/myTrades", method: .get, params: ["symbol": symbol, "limit": limit]) else { return }
//        runRequest(request: request, success: success, failure: failure)
//    }
}
