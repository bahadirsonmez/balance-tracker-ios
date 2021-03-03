//
//  AuthViewControllerFactory.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
protocol AuthViewControllerFactory {
//    func instantiateOnboardingViewController() -> OnboardingViewController
//    func instantiateWelcomeViewController() -> WelcomeViewController
    func instantiateLoginViewController() -> LoginViewController
    func instantiateRegisterViewController() -> RegisterViewController
//    func instantiateSMSViewController() -> SMSViewController
    //func instantiateOnboardingViewController() -> OnboardingController
}

//protocol WalktroughViewControllerFactory {
//    func instantiateWalktroughViewController() -> WalktroughViewController
//}

protocol TabBarControllerFactory {
    func instantiateTabBarController() -> MainTabBarController
    func instantiateBalanceViewController() -> BalanceViewController
    func instantiateAccountViewController() -> AccountViewController
    func instantiateProfileViewController() -> ProfileViewController
}

//protocol AccountControllerFactory {
//    func instantiateProfileViewController() -> UserAccountViewController
//}


