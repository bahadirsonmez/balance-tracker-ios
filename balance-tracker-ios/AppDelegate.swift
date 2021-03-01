//
//  AppDelegate.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var rootController: CoordinatorNavigationController? {
        guard let rootViewController = window?.rootViewController else {
            fatalError() // rootViewController or window is nil
        }
        if let navigationController = rootViewController as? CoordinatorNavigationController {
            return navigationController
        }
        return nil
    }

    private lazy var dependencyConatiner = DependencyContainer(rootController: self.rootController!)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.dependencyConatiner.start()
        return true
    }
}

