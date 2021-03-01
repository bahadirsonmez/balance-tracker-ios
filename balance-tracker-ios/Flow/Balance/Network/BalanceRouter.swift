//
//  BalanceRouter.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//

import Alamofire
import Foundation

enum BalanceRouter: URLRequestConvertible {
    case getBalanceList(id: String)

    static let apiURLString = "Constants.baseURL"

    public var path: String {
        switch self {
        case .getBalanceList(let id):
            return "/api/balance/\(id)"
        }
    }

    public var method: Alamofire.HTTPMethod {
        switch self {
        case .getBalanceList:
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
        case .getBalanceList:
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let accessToken = KeychainAccount.sharedAccount.accessToken
            urlRequest.addValue("Token " + accessToken!, forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }
}

