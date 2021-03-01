//
//  LaunchInstructor.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
import Foundation

enum LaunchInstructor {

    case main
    case auth
    case onboarding

    // MARK: - Public methods

    static func configure() -> LaunchInstructor {

        var isAutorized: Bool = false

        //let defaults = UserDefaults.standard
        //let tutorialWasShown = defaults.bool(forKey: "tutorialWasShown")
        let tutorialWasShown = true

        if KeychainAccount.sharedAccount.accessToken != nil {
            isAutorized = true
        }else {
            isAutorized = false
        }

        switch (tutorialWasShown, isAutorized) {
            case (true, false): return .main
            case (false, true), (false, false): return .main
            case (true, true): return .main
        }
    }
}
