//
//  ProfileCoordinator.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 20.02.2021.
//
import UIKit

final class ProfileCoordinator: BaseCoordinator, CoordinatorFinishOutput {

    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    private let router: RouterProtocol
    private let factory: Factory
    private let controller: ProfileViewController

    override func start() {
        showProfileModule()
    }

    // MARK: - Private metods
    private func showProfileModule() {
        controller.tabBarController?.selectedIndex = 2
    }

    init(controller: ProfileViewController, router: RouterProtocol, factory: Factory) {
        self.router = router
        self.factory = factory
        self.controller = controller
    }
}

