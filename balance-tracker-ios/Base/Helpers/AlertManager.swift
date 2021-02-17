//
//  AlertManager.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
import UIKit

class AlertManager {
    static func showAlertPleaseWait(_ parentController: UIViewController) {
        let alert = UIAlertController(title: nil,
                                      message: "Lütfen bekleyin...",
                                      preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()

        alert.view.addSubview(loadingIndicator)
        parentController.present(alert, animated: true, completion: nil)
    }

    static func dismiss(_ parentController: UIViewController) {
            parentController.dismiss(animated: true, completion: nil)
        }
}
