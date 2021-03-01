//
//  UIViewController+alerts.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import UIKit
import SwiftMessages

extension UIViewController {
    func showSuccess(_ title: String, body: String) {
        DispatchQueue.main.async {
            var messageView = MessageView()
            messageView = MessageView.viewFromNib(layout: .cardView)

            messageView.configureTheme(.success)
            messageView.configureDropShadow()
            messageView.button?.isHidden = true
            messageView.configureContent(title: title, body: body)
            var infoConfig = SwiftMessages.defaultConfig
            if self.isModal {
                infoConfig.presentationStyle = .center
            }else {
                infoConfig.presentationStyle = .top
            }
            infoConfig.duration = .seconds(seconds: 3.0)
            SwiftMessages.show(config: infoConfig, view: messageView)
        }
    }

    func showAlert(_ title: String, body: String)  {
        DispatchQueue.main.async {
            var messageView = MessageView()
            messageView = MessageView.viewFromNib(layout: .cardView)
            messageView.configureTheme(.error)
            messageView.configureDropShadow()
            messageView.button?.isHidden = true
            messageView.configureContent(title: title, body: body)
            var infoConfig = SwiftMessages.defaultConfig
            if self.isModal {
                infoConfig.presentationStyle = .bottom
            }else {
                infoConfig.presentationStyle = .top
            }
            infoConfig.duration = .seconds(seconds: 3)
            SwiftMessages.show(config: infoConfig, view: messageView)
        }
    }


    func showCustomAlert(_ title: String, body: String, position: SwiftMessages.PresentationStyle, duration: SwiftMessages.Duration) {
        DispatchQueue.main.async {
            var messageView = MessageView()
            messageView = MessageView.viewFromNib(layout: .cardView)
            messageView.configureTheme(.info)
            messageView.configureDropShadow()
            messageView.button?.isHidden = true
            messageView.configureContent(title: title, body: body)
            var infoConfig = SwiftMessages.defaultConfig
            infoConfig.presentationStyle = position
            infoConfig.duration = duration
            SwiftMessages.show(config: infoConfig, view: messageView)
        }
    }

    func showCenterAlert(_ title: String, body: String)  {
        DispatchQueue.main.async {
            var messageView = MessageView()
            messageView = MessageView.viewFromNib(layout: .cardView)

            messageView.configureTheme(.error)
            messageView.configureDropShadow()
            messageView.button?.isHidden = true
            messageView.configureContent(title: title, body: body)
            var infoConfig = SwiftMessages.defaultConfig
            if self.isModal {
                infoConfig.presentationStyle = .center
            }else {
                infoConfig.presentationStyle = .center
            }
            infoConfig.duration = .seconds(seconds: 2.0)
            SwiftMessages.show(config: infoConfig, view: messageView)
        }
    }

    func showAlertBottom(_ title: String, body: String)  {
        DispatchQueue.main.async {
            var messageView = MessageView()
            messageView = MessageView.viewFromNib(layout: .cardView)

            messageView.configureTheme(.error)
            messageView.configureDropShadow()
            messageView.button?.isHidden = true
            messageView.configureContent(title: title, body: body)
            var infoConfig = SwiftMessages.defaultConfig
            if self.isModal {
                infoConfig.presentationStyle = .bottom
            }else {
                infoConfig.presentationStyle = .bottom
            }
            infoConfig.duration = .seconds(seconds: 2.0)
            SwiftMessages.show(config: infoConfig, view: messageView)
        }
    }

    func showAlert(_ detail: String) {
        DispatchQueue.main.async {
            var messageView = MessageView()
            messageView = MessageView.viewFromNib(layout: .cardView)

            messageView.configureTheme(.error)
            messageView.configureDropShadow()
            messageView.button?.isHidden = true
            messageView.configureContent(title: "Dikkat".localized(), body: detail)
            var infoConfig = SwiftMessages.defaultConfig
            if self.isModal {
                infoConfig.presentationStyle = .center
            }else {
                infoConfig.presentationStyle = .top
            }
            infoConfig.duration = .seconds(seconds: 5.0)
            SwiftMessages.show(config: infoConfig, view: messageView)
        }
    }

    func showCritical(_ title: String, body: String)  {
        DispatchQueue.main.async {
            var messageView = MessageView()
            messageView = MessageView.viewFromNib(layout: .cardView)

            messageView.configureTheme(.error)
            messageView.configureDropShadow()
            messageView.button?.isHidden = true
            messageView.configureContent(title: title, body: body)
            var infoConfig = SwiftMessages.defaultConfig
            if self.isModal {
                infoConfig.presentationStyle = .center
            }else {
                infoConfig.presentationStyle = .top
            }
            infoConfig.duration = .seconds(seconds: 10.0)
            SwiftMessages.show(config: infoConfig, view: messageView)
        }
    }

    func showInfo(_ title: String, body: String) {
        DispatchQueue.main.async {
            var messageView = MessageView()
            messageView = MessageView.viewFromNib(layout: .cardView)

            messageView.configureTheme(.info)
            messageView.configureDropShadow()
            messageView.button?.isHidden = true
            messageView.configureContent(title: title, body: body)
            var infoConfig = SwiftMessages.defaultConfig
            if self.isModal {
                infoConfig.presentationStyle = .center
            }else {
                infoConfig.presentationStyle = .top
            }
            infoConfig.duration = .seconds(seconds: 1.0)
            SwiftMessages.show(config: infoConfig, view: messageView)
        }
    }

    func showButtonAlert(_ title: String, body: String)  {
        DispatchQueue.main.async {
            var messageView = MessageView()
            messageView = MessageView.viewFromNib(layout: .cardView)

            messageView.configureTheme(.error)
            messageView.configureDropShadow()
            messageView.button?.isHidden = false
            messageView.configureContent(title: title, body: body)
            messageView.button?.setTitle("Giriş".localized(), for: .normal)
            messageView.buttonTapHandler = { _ in
                SwiftMessages.hide()
            }
            var infoConfig = SwiftMessages.defaultConfig
            if self.isModal {
                infoConfig.presentationStyle = .center
            }else {
                infoConfig.presentationStyle = .top
            }
            infoConfig.duration = .seconds(seconds: 0.8)
            SwiftMessages.show(config: infoConfig, view: messageView)
        }
    }
}
