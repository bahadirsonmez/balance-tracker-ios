//
//  DependencyContainer+Extension.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
import UIKit

extension DependencyContainer: AuthViewControllerFactory {

    func instantiateLoginViewController() -> LoginViewController {
        let loginVM = LoginViewModel(manager: self.loginManager)
        let loginVC = LoginViewController(with: loginVM)
        return loginVC
    }

    func instantiateRegisterViewController() -> RegisterViewController {
        let loginVM = LoginViewModel(manager: self.loginManager)
        let registerVC = RegisterViewController(with: loginVM)
        return registerVC
    }

    func instantiateBinanceAPIViewController() -> BinanceAPIViewController {
        let loginVM = LoginViewModel(manager: self.loginManager)
        let binanceVC = BinanceAPIViewController(with: loginVM)
        return binanceVC
    }
}

extension DependencyContainer: TabBarControllerFactory {

    func instantiateTabBarController() -> MainTabBarController {
        let tabBarController = MainTabBarController()
        return tabBarController
    }

    func instantiateBalanceViewController() -> BalanceViewController{
        let vm = BalanceViewModel(manager: self.balanceManager)
        let vc = BalanceViewController()

        let image = Constants.Tab.tab0
        let selectedImage = Constants.Tab.tab0Selected
        let title = Constants.Tab.tab0Title

        vc.tabBarItem = UITabBarItem(
            title: title,
            image: image, tag: 0)
        vc.tabBarItem.selectedImage = selectedImage

        vc.viewModel = vm
        return vc
    }

    func instantiateFriendViewController() -> FriendsViewController{
        let vm = FriendsViewModel(manager: self.friendsManager)
        let vc = FriendsViewController()

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

    func instantiateFriendDetailViewController() -> FriendDetailViewController {
        let vm = FriendsViewModel(manager: self.friendsManager)
        let vc = FriendDetailViewController()
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


