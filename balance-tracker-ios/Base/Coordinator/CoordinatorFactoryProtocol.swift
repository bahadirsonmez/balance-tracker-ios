//
//  CoordinatorFactoryProtocol.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
import UIKit

protocol CoordinatorFactoryProtocol {
    func instantiateApplicationCoordinator() -> ApplicationCoordinator
//    func instantiateAuthCoordinator(router: RouterProtocol) -> AuthCoordinator
    func instantiateTabBarCoordinator(router: RouterProtocol) -> MainTabBarCoordinator
    //func instantiateOnboardingCoordinator(router: RouterProtocol) -> OnboardingCoordinator

    //func instantiateRegisterCoordinator(router: RouterProtocol) -> RegisterCoordinator

    //func instantiateAccountCoordinator(router: RouterProtocol) -> AccountCoordinator

    func makeCoordinators(routers: [RouterProtocol]) -> [Coordinator & CoordinatorFinishOutput]

    func makeTabbarCoordinator(router: RouterProtocol) -> (coordinator: Coordinator, toPresent: Presentable?)
}
