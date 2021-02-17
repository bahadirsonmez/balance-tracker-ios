//
//  AuthViewControllerFactory.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
protocol AuthViewControllerFactory {
    func instantiateOnboardingViewController() -> OnboardingViewController
    func instantiateWelcomeViewController() -> WelcomeViewController
    func instantiateLoginViewController() -> LoginViewController
//    func instantiateSMSViewController() -> SMSViewController
    //func instantiateOnboardingViewController() -> OnboardingController
}

//protocol WalktroughViewControllerFactory {
//    func instantiateWalktroughViewController() -> WalktroughViewController
//}

protocol TabBarControllerFactory {
    func instantiateTabBarController() -> MainTabBarController
    func instantiateEventViewController() -> EventViewController
    func instantiateLCVViewController() -> LCVViewController
    func instantiateContactsViewController() -> ContactsViewController
    func instantiateGiftsViewController() -> GiftsViewController
    func instantiateAccountViewController() -> AccountViewController
}

//protocol AccountControllerFactory {
//    func instantiateProfileViewController() -> UserAccountViewController
//}


