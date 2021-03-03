//
//  DependencyContainer.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//

import UIKit
import Alamofire
import FirebaseAuth

typealias Factory = CoordinatorFactoryProtocol & ViewControllerFactory
//typealias SubViewControllerFactory = AccountControllerFactory
typealias ViewControllerFactory = AuthViewControllerFactory & TabBarControllerFactory/* & SubViewControllerFactory& WalktroughViewControllerFactory*/

class DependencyContainer {

    // MARK: - Vars & Lets

    private var rootController: CoordinatorNavigationController

    // MARK: App Coordinator

    internal lazy var applicationCoordinator = self.instantiateApplicationCoordinator()


    // MARK: APi Manager

    lazy var sessionManager = Session(interceptor: APIManagerRetrier())
    //lazy var sessionManager = Session()
    lazy var retrier = APIManagerRetrier()

    // MARK: Network services

    lazy var loginManager = Auth.auth()
//    lazy var loginManager = LoginAPIManager(sessionManager: self.sessionManager, retrier: self.retrier)
    lazy var balanceManager = BalanceAPIManager(sessionManager: self.sessionManager, retrier: self.retrier)
    lazy var accountManager = AccountAPIManager(sessionManager: self.sessionManager, retrier: self.retrier)
    lazy var profileManager = ProfileAPIManager(sessionManager: self.sessionManager, retrier: self.retrier)

    // MARK: - Public func

    func start() {
        self.applicationCoordinator.start()
    }

    func reboot() {
        self.applicationCoordinator.start()
    }

    // MARK: - Initialization

    init(rootController: CoordinatorNavigationController) {
        self.rootController = rootController
        self.customizeNavigationController()
    }

    // MARK: - Private methods

    private func customizeNavigationController() {
        self.rootController.enableSwipeBack()
        self.rootController.customizeTitle(titleColor: Constants.Colors.mainTextColor,
                                           largeTextFont: Constants.Fonts.medium17,
                                           smallTextFont: Constants.Fonts.medium17,
                                           isTranslucent: true,
                                           barTintColor: Constants.Colors.backgroundColor)
        self.rootController.customizeBackButton(backButtonImage: UIImage(systemName: "arrow.backward"),
                                      backButtonTitle: "",
                                      backButtonfont: UIFont.systemFont(ofSize: 15, weight: .bold),
                                      backButtonTitleColor: .white,
                                      shouldUseViewControllerTitles: true)
    }
}

// MARK: - Extensions
// MARK: - CoordinatorFactoryProtocol

extension DependencyContainer: CoordinatorFactoryProtocol {
    func makeTabbarCoordinator(router: RouterProtocol) -> (coordinator: Coordinator, toPresent: Presentable?) {
        let controller = MainTabBarController()
        let coordinator = MainTabBarCoordinator(router: router, factory: self as Factory)
        return (coordinator, controller)
    }

    func instantiateApplicationCoordinator() -> ApplicationCoordinator {
        return ApplicationCoordinator(router: Router(rootController: rootController), factory: self as Factory, launchInstructor: LaunchInstructor.configure())
    }
    func instantiateAuthCoordinator(router: RouterProtocol) -> AuthCoordinator {
        return AuthCoordinator(router: router, factory: self as Factory)
    }

    func instantiateTabBarCoordinator(router: RouterProtocol) -> MainTabBarCoordinator {
        return MainTabBarCoordinator(router: router, factory: self as Factory)
    }

    func instantiateBalanceCoordinator(router: RouterProtocol) -> BalanceCoordinator {
        return BalanceCoordinator(controller: BalanceViewController(), router: router, factory: self as Factory)
    }

    func instantiateAccountCoordinator(router: RouterProtocol) -> AccountCoordinator {
        return AccountCoordinator(controller: AccountViewController(), router: router, factory: self as Factory)
    }

    func instantiateProfileMapCoordinator(router: RouterProtocol) -> ProfileCoordinator {
        return ProfileCoordinator(controller: ProfileViewController(), router: router, factory: self as Factory)
    }

    func makeCoordinators(routers: [RouterProtocol]) -> [Coordinator & CoordinatorFinishOutput] {
        if routers.count != 1 {
            return []
        }else {
            let mapCoordinator = instantiateBalanceCoordinator(router: routers[0])

            return[mapCoordinator]
        }
    }
}
