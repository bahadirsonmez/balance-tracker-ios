//
//  AccountCoordinator.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import UIKit

final class AccountCoordinator: BaseCoordinator, CoordinatorFinishOutput {

    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    private let router: RouterProtocol
    private let factory: Factory
    private let controller: AccountViewController

    override func start() {
        showAccountModule()
    }

    // MARK: - Private metods
    private func showAccountModule() {
        controller.tabBarController?.selectedIndex = 1
    }

    init(controller: AccountViewController, router: RouterProtocol, factory: Factory) {
        self.router = router
        self.factory = factory
        self.controller = controller
    }
}

