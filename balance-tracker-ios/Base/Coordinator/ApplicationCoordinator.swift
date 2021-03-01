//
//  ApplicationCoordinator.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {

    // MARK: - Vars & Lets
    private let factory: Factory
    private let router: RouterProtocol
    private var launchInstructor: LaunchInstructor

    //MARK: - Coordinator

    override func start(with option: DeepLinkOption?) {
        if option != nil {

        } else {
            switch launchInstructor {
            case .onboarding: runMainFlow()
            case .auth: runMainFlow()
            case .main: runMainFlow()
            }
        }
    }

    private func runOnboardingFlow() {
    }

    // MARK: - Private methods
//    private func runAuthFlow() {
//        let coordinator = self.factory.instantiateAuthCoordinator(router: self.router)
//        coordinator.finishFlow = { [unowned self, unowned coordinator] in
//            self.removeDependency(coordinator)
//            self.launchInstructor = LaunchInstructor.configure()
//            self.start()
//        }
//        self.addDependency(coordinator)
//        coordinator.start()
//    }

    public func reboot() {
        let coordinator = self.factory.instantiateTabBarCoordinator(router: self.router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }

    private func runMainFlow() {
        let coordinator = self.factory.instantiateTabBarCoordinator(router: self.router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }

    // MARK: - Init
    init(router: RouterProtocol, factory: Factory, launchInstructor: LaunchInstructor) {
        self.router = router
        self.factory = factory
        self.launchInstructor = launchInstructor
    }
}
