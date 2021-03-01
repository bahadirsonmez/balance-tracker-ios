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
    }

    init(controller: BalanceViewController, router: RouterProtocol, factory: Factory) {
        self.router = router
        self.factory = factory
        self.controller = controller
    }
}

