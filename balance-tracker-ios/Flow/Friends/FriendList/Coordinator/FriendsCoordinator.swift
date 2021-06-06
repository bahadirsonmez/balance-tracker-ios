//
//  FriendsCoordinator.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import UIKit

final class FriendsCoordinator: BaseCoordinator, CoordinatorFinishOutput {

    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    private let router: RouterProtocol
    private let factory: Factory
    private let controller: FriendsViewController

    override func start() {
        showFriendsModule()
    }

    // MARK: - Private metods
    private func showFriendsModule() {
        controller.tabBarController?.selectedIndex = 1
        controller.onFriendDetail = { item in
            self.showFriendDetailViewController(item: item)
        }
    }

    private func showFriendDetailViewController(item: FriendItem) {
        let vc = self.factory.instantiateFriendDetailViewController()
        vc.item = item
        vc.onBack = {
            self.popModule()
        }
        pushModule(vc)
    }


    init(controller: FriendsViewController, router: RouterProtocol, factory: Factory) {
        self.router = router
        self.factory = factory
        self.controller = controller
    }
}

extension FriendsCoordinator {
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


