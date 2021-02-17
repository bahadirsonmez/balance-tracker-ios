//
//  DependencyContainer.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//

import UIKit
//import Alamofire

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

//    lazy var loginManager = LoginAPIManager(sessionManager: self.sessionManager, retrier: self.retrier)
//    lazy var eventManager = EventAPIManager(sessionManager: self.sessionManager, retrier: self.retrier)
//    lazy var contactsManager = ContactsAPIManager(sessionManager: self.sessionManager, retrier: self.retrier)
//    lazy var giftsManager = GiftsAPIManager(sessionManager: self.sessionManager, retrier: self.retrier)
//    lazy var lcvManager = LCVAPIManager(sessionManager: self.sessionManager, retrier: self.retrier)
//    lazy var accountManager = AccountAPIManager(sessionManager: self.sessionManager, retrier: self.retrier)

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
        self.rootController.customizeBackButton(backButtonImage: UIImage(named: "goBack"),
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

    func instantiateLCVCoordinator(router: RouterProtocol) -> LCVCoordinator {
        return LCVCoordinator(controller: LCVViewController(), router: router, factory: self as Factory)
    }

    func instantiateAccountCoordinator(router: RouterProtocol) -> AccountCoordinator {
        return AccountCoordinator(controller: AccountViewController(), router: router, factory: self as Factory)
    }

    func instantiateGoogleMapCoordinator(router: RouterProtocol) -> GoogleMapCoordinator {
        return GoogleMapCoordinator(controller: GoogleMapViewController(), router: router, factory: self as Factory)
    }

    func makeCoordinators(routers: [RouterProtocol]) -> [Coordinator & CoordinatorFinishOutput] {
        if routers.count != 1 {
            return []
        }else {
            let mapCoordinator = instantiateLCVCoordinator(router: routers[0])

            return[mapCoordinator]
        }
    }
}
