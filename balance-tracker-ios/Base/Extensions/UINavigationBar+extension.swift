//
//  UINavigationBar+extension.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 18.02.2021.
//
import UIKit

extension UINavigationBar {

    // MARK: - Public methods
    static func customNavBarStyle(color: UIColor, largeTextFont: UIFont, smallTextFont: UIFont, isTranslucent: Bool, barTintColor: UIColor?) {
        self.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: color,
                                                      NSAttributedString.Key.font: largeTextFont]

        self.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: color,
                                                 NSAttributedString.Key.font: smallTextFont]

        self.appearance().isTranslucent = isTranslucent

        if let barTintColor = barTintColor {
            self.appearance().barTintColor = barTintColor
        }
    }

    func hideHairline() {
//        let img = UIImage()
//        self.shadowImage = img
//        self.setBackgroundImage(img, for: UIBarMetrics.default)
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView!.isHidden = true
    }

    func hideBottomHairline() {
      let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
      navigationBarImageView!.isHidden = true
    }

    func showBottomHairline() {
      let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
      navigationBarImageView!.isHidden = false
    }

    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
      if view is UIImageView && view.bounds.height <= 1.0 {
        return (view as! UIImageView)
      }

      let subviews = (view.subviews as [UIView])
      for subview: UIView in subviews {
        if let imageView: UIImageView = hairlineImageViewInNavigationBar(view: subview) {
          return imageView
        }
      }
      return nil
    }
}

extension UIToolbar {

  func hideHairline() {
    let navigationBarImageView = hairlineImageViewInToolbar(view: self)
    navigationBarImageView!.isHidden = true
  }

  func showHairline() {
    let navigationBarImageView = hairlineImageViewInToolbar(view: self)
    navigationBarImageView!.isHidden = false
  }

  private func hairlineImageViewInToolbar(view: UIView) -> UIImageView? {
    if view is UIImageView && view.bounds.height <= 1.0 {
      return (view as! UIImageView)
    }

    let subviews = (view.subviews as [UIView])
    for subview: UIView in subviews {
      if let imageView: UIImageView = hairlineImageViewInToolbar(view: subview) {
        return imageView
      }
    }
    return nil
  }
}
