//
//  BalanceCoordinator.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import UIKit

final class BalanceCoordinator: BaseCoordinator, CoordinatorFinishOutput {

    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    private let router: RouterProtocol
    private let factory: Factory
    private let controller: BalanceViewController

    override func start() {
        showBalanceModule()
    }

    // MARK: - Private metods
    private func showBalanceModule() {
        controller.tabBarController?.selectedIndex = 0
        controller.onForceLogout = {
            self.forceLogout()
        }
    }

    init(controller: BalanceViewController, router: RouterProtocol, factory: Factory) {
        self.router = router
        self.factory = factory
        self.controller = controller
    }

    func forceLogout() {
        KeychainAccount.sharedAccount.clearAll()
        self.removeDependency(self)
        self.showAuthFlow()
    }

    private func showAuthFlow() {
        let authCoordinator = self.factory.instantiateAuthCoordinator(router: router)
        addDependency(authCoordinator)
        authCoordinator.start()
    }

}

