//
//  BalanceRouter.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//

import Alamofire
import Foundation

enum BalanceRouter: URLRequestConvertible {
    case getCoinPrices

    static let apiURLString = "https://api.coinranking.com/v2"

    public var path: String {
        switch self {
        case .getCoinPrices:
            return "/coins"
        }
    }

    public var method: Alamofire.HTTPMethod {
        switch self {
        case .getCoinPrices:
            return .get
        }
    }

    public func asURLRequest() throws -> URLRequest {
        let url = try BalanceRouter.apiURLString.asURL()
        var urlRequest = URLRequest(url: (url.appendingPathComponent(path)))
        //let newURLRequest = urlRequest.description.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let newURLRequest = urlRequest.description.removingPercentEncoding
        let convertedURL = URL(string: newURLRequest!)
        urlRequest = URLRequest(url: convertedURL!)
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .getCoinPrices:
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

//            let accessToken = KeychainAccount.sharedAccount.accessToken
            urlRequest.addValue(Constants.coinRankingAPIKey, forHTTPHeaderField: "x-access-token")
        }
        return urlRequest
    }
}

