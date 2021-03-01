//
//  APIManagerRetries.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import Foundation
import Alamofire

final class APIManagerRetrier: RequestInterceptor {

    var numberOfRetries = 0

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
//        if request.task?.currentRequest?.httpMethod == "GET" {
//            guard let response = request.task?.response as? HTTPURLResponse else {
//                /// The request did not fail due to a 401 Unauthorized response.
//                /// Return the original error and don't retry the request.
//                return completion(.doNotRetryWithError(error))
//            }
//
//            if response.statusCode == 500 {
//                completion(.retryWithDelay(1.0))
//            }
//
//            if (response.statusCode == 401) && self.numberOfRetries < 3 {
//                self.numberOfRetries += 1
//                self.refreshToken(session: session, router: LoginRouter.refreshToken) {(result: Result<LoginModel, Error>) in
//                    switch result {
//                    case .success(let result):
//                        self.saveRefreshToken(result)
//                        completion(.doNotRetry)
//                    case .failure(let error):
//                        completion(.doNotRetryWithError(error))
//                    }
//                }
//            }else if (error.localizedDescription == "The operation couldn’t be completed. Software caused connection abort") {
//                completion(.doNotRetry)
//            }else if let response = request.task?.response as? HTTPURLResponse, response.statusCode >= 500, request.retryCount < 3 {
//                completion(.retryWithDelay(1.0))
//            }else {
//                completion(.doNotRetry) // don't retry
//                self.numberOfRetries = 0
//            }
//        }else {
//            guard let response = request.task?.response as? HTTPURLResponse else {
//                /// The request did not fail due to a 401 Unauthorized response.
//                /// Return the original error and don't retry the request.
//                return completion(.doNotRetryWithError(error))
//            }
//            if (response.statusCode == 401) && self.numberOfRetries < 3 {
//                self.numberOfRetries += 1
//                self.refreshToken(session: session, router: LoginRouter.refreshToken) {(result: Result<LoginModel, Error>) in
//                    switch result {
//                    case .success(let result):
//                        self.saveRefreshToken(result)
//                        completion(.doNotRetry)
//                    case .failure(let error):
//                        completion(.doNotRetryWithError(error))
//                    }
//                }
//            }else {
//                completion(.doNotRetry)
//            }
//        }
    }

//    func refreshToken<T>(session: Session, router: LoginRouter, handler: @escaping (Swift.Result<T, Error>) -> Void) where T: Codable {
//        session.request(router).validate().responseJSON { (data) in
//            print(data)
//            switch data.result {
//            case .success(_):
//                do {
//                    guard let jsonData = data.data else {
//                        throw AlertMessage(title: "Error", body: "No data")
//                    }
//                    let result = try JSONDecoder().decode(T.self, from: jsonData)
//                    handler(.success(result))
//                } catch {
//                    print(error)
//                }
//            case .failure(let error):
//                //let errorCode   = (error as NSError).code
//                //let statusCode  = data.response?.statusCode ?? errorCode
//                //                let statusCode  = data.response?.statusCode
//                //                let err = ServiceError(code: statusCode!)
//                //                let alert = AlertMessage(title: err.title, body: err.description)
//                return handler(.failure(error))
//            }
//        }
//    }

//    private func saveRefreshToken(_ model: LoginResponse) {
//        let accessToken = model.accessToken
//        let refreshToken = model.refreshToken
//        KeychainAccount.sharedAccount.setAccessToken(accessToken)
//        Account.sharedAccount.setRefreshToken(refreshToken)
//    }
}
