//
//  LoginViewModel.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 2.03.2021.
//
import Foundation
import FirebaseAuth

class LoginViewModel: NSObject {
    // MARK: - Vars & lets

    //private let loginRequest: LoginRequest
    private let manager: Auth
    var user: User?
    var isLoading: ((Bool) -> ())?
//    var loginResponse: LoginResponse?

    func loginWithEmail(email: String, password: String, success: @escaping () -> Void,
                        failure: @escaping (Error) -> Void) {
        self.isLoading?(true)
        manager.signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.isLoading?(false)
                guard let error = error else { return }
                failure(error)
            } else {
                self.isLoading?(false)
                self.user = result?.user
                KeychainAccount.sharedAccount.setAccessToken(self.user?.uid)
                print(result)
                success()
            }
        }
    }

    // MARK: - Init
    init(manager: Auth) {
        self.manager = manager
        super.init()
    }
}

