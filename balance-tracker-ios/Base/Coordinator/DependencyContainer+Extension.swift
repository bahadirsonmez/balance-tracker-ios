//
//  DependencyContainer+Extension.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
import UIKit

extension DependencyContainer: AuthViewControllerFactory {
    func instantiateOnboardingViewController() -> OnboardingViewController {
        let vc = OnboardingViewController()
        return vc
    }
    func instantiateWelcomeViewController() -> WelcomeViewController {
        let welcomeVC = WelcomeViewController()
        return welcomeVC
    }

    func instantiateLoginViewController() -> LoginViewController {
        let loginVM = LoginViewModel(manager: self.loginManager)
        let loginVC = LoginViewController(with: loginVM)
        return loginVC
    }

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

    func instantiateEventViewController() -> EventViewController{
        let eventVM = EventViewModel(manager: self.eventManager)
        let eventVC = EventViewController()

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

    func instantiateLCVViewController() -> LCVViewController{
        let vm = LCVViewModel(manager: self.lcvManager)
        let vc = LCVViewController()

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

    func instantiateContactsViewController() -> ContactsViewController{
        let vm = ContactsViewModel(manager: self.contactsManager)
        let vc = ContactsViewController()

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

    func instantiateGiftsViewController() -> GiftsViewController{
        let vm = GiftsViewModel(manager: self.giftsManager)
        let vc = GiftsViewController()

        //let image = Constants.Tab.gifts
        //let selectedImage = Constants.Tab.homeSelected
        //let title = Constants.Tab.giftsTitle

//        vc.tabBarItem = UITabBarItem(
//            title: title,
//            image: image, tag: 0)
        //vc.tabBarItem.selectedImage = selectedImage

        vc.viewModel = vm
        return vc
    }

    func instantiateAccountViewController() -> AccountViewController {
        let vm = AccountViewModel(manager: self.accountManager)
        let vc = AccountViewController()

        let image = Constants.Tab.tab3
        let selectedImage = Constants.Tab.tab3Selected
        let title = Constants.Tab.tab3Title

        vc.tabBarItem = UITabBarItem(
            title: title,
            image: image, tag: 3)
        vc.tabBarItem.selectedImage = selectedImage

        vc.viewModel = vm
        return vc
    }

}


