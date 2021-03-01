//
//  ServiceError.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import Foundation

class ErrorModel {
    var title: String = "Dikkat".localized()
    var detail: String

    init(detail: String) {
        self.detail = detail
    }
}

enum ServiceError {
    case invalidRequest
    case noAuthorized
    case notFound
    case badGateway
    case timeOut
    case notMapped
    case noInternet
    case requestTimeOut
    case softwareConnectionError
    case unauth
    case unknown
    case internalServerError
    case existingUser
    case userNotFound
    case cannotProcessData
    case dataExist
    case mernisError
    case serverError
    case test
    case notValid
    case noRecord
    case serverConnectionError

    // Personal info
    // 452 : Mernis Identity record mismatch
    case mernisMismatch
    // 453 : First Name, Last Name, Birth Date is required
    case mernisRegFields
    // 454 : Register file upload fail
    case registerUploadFail

    var code: Int {
        switch self {
        case .invalidRequest: return 400
        case .noAuthorized: return 403
        case .notFound: return 404
        case .unauth: return 401
        case .badGateway: return 502
        case .timeOut: return 504
        case .noInternet: return 1009
        case .requestTimeOut: return 1001
        case .softwareConnectionError: return 53
        case .unknown: return -1
        case .internalServerError: return 500
        case .existingUser: return 409
        case .userNotFound: return 461
        case .dataExist: return 501
        case .mernisError: return 407
        case .serverError: return 1004
        case .notValid: return 406
        case .test: return 13
        case .noRecord: return 204
        case .mernisMismatch: return 452
        case .mernisRegFields: return 453
        case .registerUploadFail: return 454
        case .serverConnectionError: return 13
        default: return 0
        }
    }

    var description: String {
        switch self {
        case .invalidRequest: return "Geçersiz istek".localized()
        case .noAuthorized: return "Yetkiniz yok".localized()
        case .notFound: return "Aradığınız bulunamadı".localized()
        case .badGateway: return "Sunucuya erişilemiyor".localized()
        case .timeOut: return "İstek zaman aşımına uğradı".localized()
        case .noInternet: return "İnternet bağlantı sorunu".localized()
        case .softwareConnectionError: return "Yazılım sunucuya ulaşamadı hatası hata".localized()
        case .requestTimeOut: return "İstek zaman aşımına uğradı".localized()
        case .unauth: return "Yetkiniz yok".localized()
        case .unknown: return "bilinmiyor".localized()
        case .internalServerError: return "Sunucu hatası".localized()
        case .existingUser: return "Kullanıcı sistemde kayıtlı".localized()
        case .userNotFound: return "Kullanıcı kaydı bulunamadı".localized()
        case .dataExist: return "Sistemde kayıt var".localized()
        case .mernisError: return "Mernis hatası, bilgilerinizi kontrol ediniz.".localized()
        case .serverError: return "Sunucuya ulaşılamıyor.".localized()
        case .test: return "Internet bağlantınız yok".localized()
        case .notValid: return "Geçerli değil".localized()
        case .noRecord: return "Kayıt bulunamadı".localized()
        case .mernisMismatch: return "Mernis hatası, bilgilerinizi kontrol ediniz.".localized()
        case .mernisRegFields: return "Ad, soyad, doğum tarihi gerekiyor.".localized()
        case .registerUploadFail: return "Dosya yükleme başarısız".localized()
        case .serverConnectionError: return "Sunucu bağlantı hatası".localized()
        default: return "Hata oluştu".localized()
        }
    }

    var title: String {
        switch self {
        default:
            return "Hata".localized()
        }
    }

    init(code: Int) {
        switch code {
        case 400: self = .invalidRequest
        case 401: self = .unauth
        case 403: self = .noAuthorized
        case 404: self = .notFound
        case 502: self = .badGateway
        case 504: self = .timeOut
        case 1009: self = .noInternet
        case 53: self = .softwareConnectionError
        case 1001: self = .requestTimeOut
        case -1: self = .unknown
        case 500: self = .internalServerError
        case 409: self = .existingUser
        case 461: self = .userNotFound
        case 501: self = .dataExist
        case 407: self = .mernisError
        case 1004: self = .serverError
        case 13: self = .serverConnectionError
        case 406: self = .notValid
        case 204: self = .noRecord
        case 452: self = .mernisMismatch
        case 453: self = .mernisRegFields
        case 454: self = .registerUploadFail
        //case 13: self = .serverConnectionError
        default: self = .notMapped
        }
    }
}

