//
//  LoginRouter.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 2.03.2021.
//

import Alamofire
import Foundation

enum LoginRouter: URLRequestConvertible {
    case login(parameters: Parameters)
    case passwordReset(parameters: Parameters)
    case davet

    static let baseURLString = ""
    static let AuthorizationHeaderKey = "X-MFA-TOKEN"

    public var path: String {
        switch self {
        case .login:
            return "/api/membership/login"
        case .passwordReset:
            return "/api/membership/reset_password"
        case .davet:
            return "test"
        }
    }

    public var method: Alamofire.HTTPMethod {
        switch self {
        case .login, .passwordReset:
            return .post
        case .davet:
            return .get
        }
    }

    public func asURLRequest() throws -> URLRequest {
        let url = try LoginRouter.baseURLString.asURL()
        var urlRequest = URLRequest(url: (url.appendingPathComponent(path)))
        let newURLRequest = urlRequest.description.removingPercentEncoding
        let convertedURL = URL(string: newURLRequest!)
        urlRequest = URLRequest(url: convertedURL!)
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .login(let parameters), .passwordReset(let parameters):
//            urlRequest.httpBody = parameters.encodeForHTTPBody()
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .davet:
            print("")
        }
        return urlRequest
    }
}
