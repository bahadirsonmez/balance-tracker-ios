//
//  AuthCoordinator.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 2.03.2021.
//
import UIKit

final class AuthCoordinator: BaseCoordinator, CoordinatorFinishOutput {

    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: - Vars & Lets

    private let router: RouterProtocol
    private let factory: Factory

    // MARK: - Private methods

//    private func performMainFlow() {
//        let coordinator = self.factory.instantiateTabBarCoordinator(router: self.router)
//        coordinator.finishFlow = { [weak self, weak coordinator] in
//            self?.removeDependency(coordinator)
//            self?.start()
//        }
//        addDependency(coordinator)
//        coordinator.start()
//    }

    private func performMainFlow() {
        let (coordinator, module) = self.factory.makeTabbarCoordinator(router: router)
        addDependency(coordinator)
        self.router.setRootModule(module, hideBar: false, animated: true)
        coordinator.start()
    }


    private func showAuthFlow() {
        let authCoordinator = self.factory.instantiateAuthCoordinator(router: router)
        addDependency(authCoordinator)
        authCoordinator.start()
    }

    private func performLoginFlow() {
        let vc = self.factory.instantiateLoginViewController()
        vc.onBack = { [unowned self] in
            self.popModule()
        }
        vc.onFinishLogin = { [unowned self] in
            if $0 {
                self.performMainFlow()
            }
            print("login done")
        }
        vc.onRegister = { [unowned self] in
            self.showRegisterViewController()
        }
        vc.onContinue = { [unowned self] in
            self.performMainFlow()
        }
        setRootModule(vc)
    }

    private func showRegisterViewController() {
        let vc = self.factory.instantiateRegisterViewController()
        vc.onBack = { [unowned self] in
            self.popModule()
        }
        vc.onLogin = { [unowned self] in
            self.popModule()
            self.performLoginFlow()
        }
        vc.onFinishRegister = { [unowned self] in
            if $0 {
                self.showBinanceAPIViewController()
            }
            print("register done")
        }
        pushModule(vc)
    }

    private func showBinanceAPIViewController() {
        let vc = self.factory.instantiateBinanceAPIViewController()
        vc.onBack = { [unowned self] in
            self.popModule()
        }
        vc.onContinue = { [unowned self] in
            self.performMainFlow()
        }
        pushModule(vc)
    }


//    private func showPhoneViewController() {
//        let vc = self.factory.instantiatePhoneViewController()
//        vc.onBack = { [unowned self] in
//            self.popModule()
//        }
//        vc.onFinishPhoneAuth = { [unowned self] in
//            if $0 {
//                self.showOTPViewController()
//            }
//            print("phone auth done")
//        }
//        pushModule(vc)
//    }
//
//    private func showOTPViewController() {
//        let vc = self.factory.instantiateOTPViewController()
//        vc.onBack = { [unowned self] in
//            self.popModule()
//        }
//        vc.onFinishOTP = { [unowned self] in
//            if $0 {
//                self.runMainFlow()
//            }
//            print("otp done")
//        }
//        pushModule(vc)
//    }
    // MARK: - Coordinator

    override func start() {
//        performWelcomeFlow()
        performLoginFlow()
    }

    // MARK: - Init

    init(router: RouterProtocol, factory: Factory) {
        self.router = router
        self.factory = factory
    }

}

extension AuthCoordinator {
    func pushModule(_ vc: UIViewController) {
        self.router.push(vc, transition: FadeAnimator(animationDuration: 0.2, isPresenting: true), animated: true, hideBack: false)
    }

    func popModule() {
        self.router.popModule(transition: FadeAnimator(animationDuration: 0.2, isPresenting: false))
    }

    func dismissModule() {
        self.router.dismissModule()
    }

    func popupToRootModule() {
        self.router.popToRootModule(animated: true)
    }

    func setRootModule(_ vc: UIViewController) {
        self.router.setRootModule(vc, hideBar: false, animated: false)
    }
    func presentModule(_ vc: UIViewController) {
        self.router.present(vc)
    }
}
