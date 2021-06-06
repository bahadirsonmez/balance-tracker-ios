//
//  MainTabbarCoordinator.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import UIKit

final class MainTabBarCoordinator: BaseCoordinator, CoordinatorFinishOutput{

    // MARK: - CoordinatorFinishOutput
    var finishFlow: (() -> Void)?

    // MARK: - Vars & Lets
    private let router: RouterProtocol
    private let factory: Factory
    private var tabBarController: MainTabBarController?
    private var tabBarCoordinator: BaseCoordinator?

    // MARK: - Puplic methods
    override func start() {
        setupTabBarController()
    }

    // MARK: - Private methods

    private func setupTabBarController() {
        let tabBarController = factory.instantiateTabBarController()
        let balanceController = factory.instantiateBalanceViewController()
        let friendsController = factory.instantiateFriendViewController()
        let profileController = factory.instantiateProfileViewController()

        tabBarController.viewControllers = [
            balanceController,
            friendsController,
            profileController
        ]

        tabBarController.toBalance = {[weak self] in
            self?.showNextModule(balanceController)
        }
        tabBarController.toFriends = {[weak self] in
            self?.showNextModule(friendsController)
        }
        tabBarController.toProfile = {[weak self] in
            self?.showNextModule(profileController)
        }

        addFirstModule(balanceController)
        router.setRootModule(tabBarController, hideBar: false, animated: false)
        self.tabBarController = tabBarController

    }

    private func addFirstModule(_ controller: BalanceViewController) {
        tabBarCoordinator = BalanceCoordinator(controller: controller, router: router, factory: factory)
        tabBarCoordinator?.start()
    }

    private func showNextModule(_ controller: UIViewController) {
        switch controller {
        case controller as BalanceViewController:
            tabBarCoordinator = BalanceCoordinator(controller: controller as! BalanceViewController, router: router, factory: factory)
        case controller as FriendsViewController:
            tabBarCoordinator = FriendsCoordinator(controller: controller as! FriendsViewController, router: router, factory: factory)
        case controller as ProfileViewController:
            tabBarCoordinator = ProfileCoordinator(controller: controller as! ProfileViewController, router: router, factory: factory)
        default:
            break
        }
        tabBarCoordinator?.start()
    }

    // MARK: - Init

    init(router: RouterProtocol, factory: Factory) {
        self.router = router
        self.factory = factory
    }

    private func setCoordinators(_ coordinators: [ Coordinator & CoordinatorFinishOutput]) {
        coordinators.forEach {[unowned self](coordinator) in
            var coordinator = coordinator
            coordinator.finishFlow = {  [unowned self, unowned coordinator] in
                self.removeDependency(coordinator)
                self.start()
            }
            coordinator.start()
        }
    }
}
