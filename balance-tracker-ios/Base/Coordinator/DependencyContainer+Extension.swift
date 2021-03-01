//
//  DependencyContainer+Extension.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
import UIKit

extension DependencyContainer: AuthViewControllerFactory {
//    func instantiateOnboardingViewController() -> OnboardingViewController {
//        let vc = OnboardingViewController()
//        return vc
//    }
//    func instantiateWelcomeViewController() -> WelcomeViewController {
//        let welcomeVC = WelcomeViewController()
//        return welcomeVC
//    }
//
//    func instantiateLoginViewController() -> LoginViewController {
//        let loginVM = LoginViewModel(manager: self.loginManager)
//        let loginVC = LoginViewController(with: loginVM)
//        return loginVC
//    }

//    func instantiateSMSViewController() -> SMSViewController {
//        let loginVM = LoginViewModel(manager: self.loginManager)
//        let smsVC = SMSViewController(with: loginVM)
//        return smsVC
//    }
}

extension DependencyContainer: TabBarControllerFactory {

    func instantiateTabBarController() -> MainTabBarController {
        let tabBarController = MainTabBarController()
        return tabBarController
    }

    func instantiateBalanceViewController() -> BalanceViewController{
        let binanceAPI = BinanceAPI(key: "AHYsxSFQXzlCeoByVELgCQes6xo7oYV5pLYtl03udOcNkpI8C3W8JtwrKJPLmD1x",
                                    secret: "KZbsaybbUFTLPvXFbwzwIOk6VVs7kNr4TIvMD7OifzLAgTNAruLeB0xcpLHnVxN8")
        let eventVM = BalanceViewModel(manager: self.balanceManager, binance: binanceAPI)
        let eventVC = BalanceViewController()

        let image = Constants.Tab.tab0
        let selectedImage = Constants.Tab.tab0Selected
        let title = Constants.Tab.tab0Title

        eventVC.tabBarItem = UITabBarItem(
            title: title,
            image: image, tag: 0)
        eventVC.tabBarItem.selectedImage = selectedImage

        eventVC.viewModel = eventVM
        return eventVC
    }

    func instantiateAccountViewController() -> AccountViewController{
        let vm = AccountViewModel(manager: self.accountManager)
        let vc = AccountViewController()

        let image = Constants.Tab.tab1
        let selectedImage = Constants.Tab.tab1Selected
        let title = Constants.Tab.tab1Title

        vc.tabBarItem = UITabBarItem(
            title: title,
            image: image, tag: 1)
        vc.tabBarItem.selectedImage = selectedImage

        vc.viewModel = vm
        return vc
    }

    func instantiateProfileViewController() -> ProfileViewController{
        let vm = ProfileViewModel(manager: self.profileManager)
        let vc = ProfileViewController()

        let image = Constants.Tab.tab2
        let selectedImage = Constants.Tab.tab2Selected
        let title = Constants.Tab.tab2Title

        vc.tabBarItem = UITabBarItem(
            title: title,
            image: image, tag: 2)
        vc.tabBarItem.selectedImage = selectedImage

        vc.viewModel = vm
        return vc
    }
}


