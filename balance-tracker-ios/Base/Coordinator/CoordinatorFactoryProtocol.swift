//
//  CoordinatorFactoryProtocol.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
import UIKit

protocol CoordinatorFactoryProtocol {
    func instantiateApplicationCoordinator() -> ApplicationCoordinator
    func instantiateAuthCoordinator(router: RouterProtocol) -> AuthCoordinator

    func instantiateTabBarCoordinator(router: RouterProtocol) -> MainTabBarCoordinator
    func instantiateBalanceCoordinator(router: RouterProtocol) -> BalanceCoordinator
    func instantiateProfileCoordinator(router: RouterProtocol) -> ProfileCoordinator
    func instantiateFriendsCoordinator(router: RouterProtocol) -> FriendsCoordinator

    func makeCoordinators(routers: [RouterProtocol]) -> [Coordinator & CoordinatorFinishOutput]

    func makeTabbarCoordinator(router: RouterProtocol) -> (coordinator: Coordinator, toPresent: Presentable?)
}
