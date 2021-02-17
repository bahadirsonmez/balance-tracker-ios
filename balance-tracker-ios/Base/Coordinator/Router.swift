//
//  Router.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
import UIKit

protocol RouterProtocol: Presentable {

    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?, animated: Bool, modalPresentationSytle: UIModalPresentationStyle)
    func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    func present(_ module: Presentable?, animated: Bool, transition: UIViewControllerAnimatedTransitioning?)
    func presentWithNav(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, hideBack: Bool)
    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?)

    func popModule()
    func popModule(transition: UIViewControllerAnimatedTransitioning?)
    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool)

    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)

    func setRootModule(_ module: Presentable?, animated: Bool)
    func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool)

    func setRootPresentModule(_ module: Presentable?, animated: Bool)
    func setRootPresentModule(_ module: Presentable?, hideBar: Bool, animated: Bool)

    func popToRootModule(animated: Bool)
    func popToModule(module: Presentable?, animated: Bool)

    func showTitles()
    func hideTitles()
    func hideBackButton()
}

final class Router: NSObject, RouterProtocol {

    // MARK: - Vars & Lets

    private weak var rootController: CoordinatorNavigationController?
    private var completions: [UIViewController : () -> Void]
    private var transition: UIViewControllerAnimatedTransitioning?

    // MARK: - Presentable

    func toPresent() -> UIViewController? {
        return self.rootController
    }

    // MARK: - RouterProtocol

    func present(_ module: Presentable?) {
        self.present(module, animated: true)
    }

    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.present(controller, animated: animated, completion: nil)
    }

    func presentWithNav(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        let navController: CoordinatorNavigationController = CoordinatorNavigationController(rootViewController: controller)
        self.rootController?.present(navController, animated: animated, completion: nil)
    }

    func present(_ module: Presentable?, animated: Bool, modalPresentationSytle: UIModalPresentationStyle) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = modalPresentationSytle
        controller.transitioningDelegate = rootController!.transitioningDelegate
        self.rootController?.present(controller, animated: animated, completion: nil)
    }

    func present(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.present(controller, animated: animated, completion: completion)
    }

    func present(_ module: Presentable?, animated: Bool, transition: UIViewControllerAnimatedTransitioning?) {
        self.rootController?.setTransition(transition: transition)
        guard let controller = module?.toPresent() else { return }
        controller.transitioningDelegate = rootController!.transitioningDelegate
        controller.modalPresentationStyle = .custom
        self.rootController?.present(controller, animated: animated, completion: nil)
    }

    func push(_ module: Presentable?)  {
        self.push(module, transition: nil)
    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?) {
        self.push(module, transition: transition, animated: true)
    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool)  {
        self.push(module, transition: transition, animated: animated, completion: nil)
    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, hideBack: Bool) {
        self.push(module, transition: transition, animated: animated, hideBack: hideBack, completion: nil)

    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, completion: (() -> Void)?) {
        self.rootController?.setTransition(transition: transition)

        guard let controller = module?.toPresent(),
            (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }

        if let completion = completion {
            self.completions[controller] = completion
        }
        self.rootController?.backButtonHidden = false
        self.rootController?.pushViewController(controller, animated: animated)
    }

    func push(_ module: Presentable?, transition: UIViewControllerAnimatedTransitioning?, animated: Bool, hideBack: Bool, completion: (() -> Void)?) {
        self.rootController?.setTransition(transition: transition)

        guard let controller = module?.toPresent(),
            (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }

        if let completion = completion {
            self.completions[controller] = completion
        }
        self.rootController?.backButtonHidden = hideBack
        self.rootController?.pushViewController(controller, animated: animated)
    }

    func popModule()  {
        self.popModule(transition: nil)
    }

    func popModule(transition: UIViewControllerAnimatedTransitioning?) {
        self.popModule(transition: transition, animated: true)
    }

    func popModule(transition: UIViewControllerAnimatedTransitioning?, animated: Bool) {
        self.rootController?.setTransition(transition: transition)
        if let controller = rootController?.popViewController(animated: animated) {
            self.runCompletion(for: controller)
        }
    }

    func popToModule(module: Presentable?, animated: Bool = true) {
        if let controllers = self.rootController?.viewControllers , let module = module {
            for controller in controllers {
                if controller == module as! UIViewController {
                    self.rootController?.popToViewController(controller, animated: animated)
                    self.runCompletion(for: controller)
                    break
                }
            }
        }
    }

    func dismissModule() {
        self.dismissModule(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        self.rootController?.dismiss(animated: animated, completion: completion)
    }

    func setRootModule(_ module: Presentable?, animated: Bool) {
        self.setRootModule(module, hideBar: false, animated: animated)
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.setViewControllers([controller], animated: animated)
        self.rootController?.isNavigationBarHidden = hideBar
    }

    func setRootPresentModule(_ module: Presentable?, animated: Bool) {
        self.setRootPresentModule(module, hideBar: false, animated: animated)
    }

    func setRootPresentModule(_ module: Presentable?, hideBar: Bool, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.setViewControllers([controller], animated: animated)
        self.rootController?.isNavigationBarHidden = hideBar
    }

    func popToRootModule(animated: Bool) {
        if let controllers = self.rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                self.runCompletion(for: controller)
            }
        }
    }

    func showTitles() {
        self.rootController?.isNavigationBarHidden = false
        self.rootController?.navigationBar.prefersLargeTitles = true
        self.rootController?.navigationBar.tintColor = UIColor.black
    }

    func hideTitles() {
        self.rootController?.isNavigationBarHidden = true
    }

    func hideBackButton() {
        self.rootController?.navigationItem.hidesBackButton = true
    }

    // MARK: - Private methods

    private func runCompletion(for controller: UIViewController) {
        guard let completion = self.completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }

    // MARK: - Init methods

    init(rootController: CoordinatorNavigationController) {
        self.rootController = rootController
        self.completions = [:]
        super.init()
        self.rootController?.delegate = self
        //self.rootController?.transitioningDelegate = self
    }
}

extension Router: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }

}

//extension Router:  UIViewControllerTransitioningDelegate {
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self.transition
//    }
//
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self.transition
//    }
//}
