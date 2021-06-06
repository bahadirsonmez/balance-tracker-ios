//
//  BalanceAPIManager.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//

import Alamofire
import Foundation

class BalanceAPIManager {

    // MARK: - Vars & Lets
    private let sessionManager: Session
    private let retrier: APIManagerRetrier

    private var skyError: SkyErrorModel?

    private func parseAPIResponse<T>(data: AFDataResponse<Any>?, handler: @escaping (Swift.Result<T, APIError>) -> Void) where T: Codable {
        do {
            guard let jsonData = data?.data else {
                throw APIError(0, data, "JSON Boş".localized())
            }
            let result = try JSONDecoder().decode(T.self, from: jsonData)
            handler(.success(result))
        } catch {
            guard let decodingError = error as? DecodingError else {
                return
            }
            switch decodingError {
            case let .typeMismatch(_, context):
                handler(.failure(APIError(1, nil, "\(context.codingPath) " + context.debugDescription)))
            case let .dataCorrupted(context):
                handler(.failure(APIError(2, nil, context.debugDescription)))
            case let .keyNotFound(key, context):
                handler(.failure(APIError(3, nil, "\(key) " + context.debugDescription)))
            default:
                break
            }
        }
    }

    private func parseAPIError(data: AFDataResponse<Any>?, handler: @escaping (Swift.Result<APIError, APIError>) -> Void) {
        do {
            guard let jsonData = data?.data else {
                throw APIError(0, data, "Error JSON Boş".localized())
            }
            let result = try JSONDecoder().decode(SkyErrorModel.self, from: jsonData)
            let statusCode = data?.response?.statusCode
            var detail = ""
            if let message = result.detail {
                detail = message
            }else {
                if statusCode == 456 {
                    detail = "Constants.Alerts.wrongVoucher"
                }
            }
            //result.error = statusCode
            handler(.failure(APIError(0, nil, detail)))
        } catch {
            //            guard let decodingError = error as? DecodingError else {
            //                return
            //            }
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case let .typeMismatch(object, context):
                    handler(.failure(APIError(1, nil, "\(object) " + context.debugDescription)))
                case let .dataCorrupted(context):
                    handler(.failure(APIError(2, nil, context.debugDescription)))
                case let .keyNotFound(key, context):
                    handler(.failure(APIError(3, nil, "\(key) " + context.debugDescription)))
                default:
                    break
                }
            }

            if let skyError = error as? APIError {
                switch skyError.data?.error {
                case .sessionTaskFailed(error: _):
                    handler(.failure(APIError(-1, nil, "İstek zaman aşımına uğradı.".localized())))
                case .requestRetryFailed(retryError: _, originalError: _):
                    handler(.failure(APIError(-2, nil, "Yeniden deneme hatası".localized())))
                default:
                    handler(.failure(APIError(-100, nil, "Hata oluştu, tekrar deneyin.".localized())))
                }
            }
        }
    }

    func callWH<T>(router: BalanceRouter, handler: @escaping (Swift.Result<T, APIError>) -> Void) where T: Codable {
        self.sessionManager.request(router).validate(statusCode: 200..<300).responseJSON { (data) in
            print(router)
            print(data)
            switch data.result {
            case .success(_):
                self.parseAPIResponse(data: data) { (result: Result<T, APIError>) in
                    switch result{
                    case .success(let data):
                        self.resetNumberOfRetries()
                        handler(.success(data))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            case .failure(_):
                self.parseAPIError(data: data) { (result: Result<APIError, APIError>) in
                    switch result{
                    case .success(let data):
                        handler(.failure(data))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            }
        }
    }

    func call<T>(router: BalanceRouter, handler: @escaping (Swift.Result<T, APIError>) -> Void) where T: Codable {
        self.sessionManager.request(router/*, interceptor: interceptor*/).validate(statusCode: 200..<300).responseJSON { (data) in
            switch data.result {
            case .success(_):
                self.parseAPIResponse(data: data) { (result: Result<T, APIError>) in
                    switch result{
                    case .success(let data):
                        self.resetNumberOfRetries()
                        handler(.success(data))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            case .failure(_):
                self.parseAPIError(data: data) { (result: Result<APIError, APIError>) in
                    switch result{
                    case .success(let data):
                        handler(.failure(data))
                    case .failure(let error):
                        handler(.failure(error))
                    }
                }
            }
        }
    }

    func call(router: BalanceRouter, handler: @escaping(CoinPrices?, Error?) -> Void) {
        self.sessionManager.request(router).validate(statusCode: 200..<300).responseJSON { (response) in
            switch response.result {
            case .success:
                if let jsonData = response.data {

                    print(jsonData)
                    let jsonDecoder = JSONDecoder()
                    do {
                        let workoutCards = try jsonDecoder.decode(CoinPrices.self, from: jsonData)
                        handler(workoutCards, nil)
                    }catch let error{
                        print(error.localizedDescription)
                        handler(nil, error)
                    }
                }
            case .failure(let error):
                handler(nil, error)
            }
        }
    }

    func callResponse(router: BalanceRouter, handler: @escaping(String?, SkyErrorModel?) -> Void){
        self.sessionManager.request(router).validate(statusCode: 200..<300).responseString { (data) in
            switch data.result {
            case .success(let value):
                handler(value, nil)
            case .failure(_):
                do {
                    guard let jsonData = data.data else {
                        throw AlertMessage(title: "Error", body: "No data")
                    }
                    let result = try JSONDecoder().decode(SkyErrorModel.self, from: jsonData)
                    //let errorCode   = (error as NSError).code
                    //let statusCode  = data.response?.statusCode ?? errorCode
//                    let statusCode = data.response?.statusCode
                    //result.error = statusCode
                    handler(nil, result)
                } catch {
                    print(error)
                }
            }
        }
    }


//    func refreshToken<T>(router: LoginRouter, handler: @escaping (Swift.Result<T, SkyErrorModel>) -> Void) where T: Codable {
//        self.sessionManager.request(router).validate(statusCode: 200..<300).responseJSON { (data) in
//            print(data)
//            switch data.result {
//            case .success(_):
//                do {
//                    guard let jsonData = data.data else {
//                        throw AlertMessage(title: "Error", body: "No data")
//                    }
//                    let result = try JSONDecoder().decode(T.self, from: jsonData)
//                    handler(.success(result))
//                    self.resetNumberOfRetries()
//                } catch {
//                    print(error)
//                }
//            case .failure(_):
//                do {
//                    guard let jsonData = data.data else {
//                        throw AlertMessage(title: "Error", body: "No data")
//                    }
//                    let result = try JSONDecoder().decode(SkyErrorModel.self, from: jsonData)
//                    //let errorCode   = (error as NSError).code
//                    //let statusCode  = data.response?.statusCode ?? errorCode
////                    let statusCode = data.response?.statusCode
//                    //result.error = statusCode
//                    handler(.failure(result))
//                } catch {
//                    print(error)
//                }
//            }
//        }
//    }

    // MARK: - Private methods

//    private func saveRefreshToken(_ model: LoginResponse) {
//        //        let accessToken = model.accessToken
//        //        let refreshToken = model.refreshToken
//        //
////                Account.sharedAccount.setAccessToken(accessToken)
//        //        KeychainAccount.sharedAccount.setRefreshToken(refreshToken)
//    }

    private func resetNumberOfRetries() {
        self.retrier.numberOfRetries = 0
    }

    private func parseApiError(data: Data?) -> AlertMessage {
        let decoder = JSONDecoder()
        if let jsonData = data, let error = try? decoder.decode(NetworkError.self, from: jsonData) {
            return AlertMessage(title: "Constants.errorAlertTitle", body: error.key ?? error.message)
        }
        return AlertMessage(title: "Constants.errorAlertTitle", body: "Constants.genericErrorMessage")
    }

    init(sessionManager: Session, retrier: APIManagerRetrier) {
        self.sessionManager = sessionManager
        self.retrier = retrier
    }
}
