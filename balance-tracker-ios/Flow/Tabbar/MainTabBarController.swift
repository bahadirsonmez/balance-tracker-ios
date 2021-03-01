//
//  MainTabBarController.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    var toBalance: (() -> Void)?
    var toAccount: (() -> Void)?
    var toProfile: (() -> Void)?

    var duration = 0.0

    private let defaults = UserDefaults.standard

    // MARK: - Lifecycle ViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .white
        self.delegate = self
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
//        tabBar.tintColor = Constants.Colors.bolomio
        tabBar.addShadow(offset: .init(width: 2, height: -5),
                         color: UIColor.init(rgba: "#54575C"),
                         opacity: 0.1,
                         radius: 17)
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        toBalance?()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // TODO: - Discuss
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        tabBar.frame.size.height = 110
//        tabBar.frame.origin.y = view.frame.height - 110
    }


    private func notificationAnimation(_ itemTag: Int) {
        let tabItemView = tabBar.subviews[itemTag + 1]
        let tabItemImageView = tabItemView.subviews.first as? UIImageView
        tabItemImageView?.contentMode = .center

        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        impliesAnimation.values = [0.0 ,-8.0, 4.0, -4.0, 3.0, -2.0, 0.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.isRemovedOnCompletion = true
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic

        tabItemImageView?.layer.add(impliesAnimation, forKey: nil)
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //notificationAnimation(item.tag)
    }

    func setupForInRent() {

    }
}

// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {

    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case viewController as BalanceViewController:
            toBalance?()
        case viewController as AccountViewController:
            toAccount?()
        case viewController as ProfileViewController:
            toProfile?()
        default:
            break
        }

        return false
    }
}
