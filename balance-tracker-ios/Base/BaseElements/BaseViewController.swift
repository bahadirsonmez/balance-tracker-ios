//
//  BaseViewController.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//

import UIKit
//import SwiftMessages
//import Lottie

class BaseViewController: UIViewController, CoordinatorNavigationControllerDelegate {
    let account = KeychainAccount.sharedAccount
    let fonts = Constants.Fonts.self
    let colors = Constants.Colors.self
    let shadow = Constants.Shadow.self
    let texts = Constants.Texts.self

    var onForceLogout: (() -> Void)?

//    var activityIndicatorView: ActivityIndicatorView!
//    var loadingView: LoadingView!
//    var messageView = MessageView()

    //let analytics = AnalyticManager.sharedInstance
    // MARK: - Controller lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController as? CoordinatorNavigationController {
            navigationController.swipeBackDelegate = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //view.backgroundColor = Constants.Colors.backgroundColor
        self.setupNavigationController()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Private methods
    private func setupNavigationController() {
        navigationController?.navigationBar.hideHairline()
        let appearance = UINavigationBarAppearance()
        //appearance.backgroundColor = UIColor(rgba: "#f1eee4")
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    // MARK: - SwipeBackNavigationControllerDelegate
    internal func transitionBackFinished() {}

    internal func didSelectCustomBackAction() {}

    func forceLogout(_ code: Int) {
        if code == 462 || code == 461 || code == 401 {
            self.onForceLogout?()
        }
    }

    func showActivityIndicator() {
//        progressHUD.animationFileName = "loader"
//        progressHUD.hudHeight = 200
//        progressHUD.hudWidth = 200
//        progressHUD.hudBackgroundColor = .blue
//        self.view.addSubview(progressHUD)
//        progressHUD.show()
        AlertManager.showAlertPleaseWait(self)
    }

    func stopActivityIndicator() {
        //progressHUD.hide()
        AlertManager.dismiss(self)
    }

    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0 , width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    func resizeImageForUpload(image: UIImage, size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
