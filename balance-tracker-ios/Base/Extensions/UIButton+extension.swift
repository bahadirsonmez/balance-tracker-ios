//
//  UIButton+extension.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 18.02.2021.
//
import UIKit

extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}

extension UIButton {
    func loadingIndicator(_ show: Bool, color : UIColor) {
        let tag = 808404
        if show {
            let indicator = UIActivityIndicatorView()
            indicator.style = UIActivityIndicatorView.Style.medium
            indicator.color = color
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            self.setTitleColor(.clear, for: .normal)
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            self.isUserInteractionEnabled = false
            self.alpha = 1.0
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
//            self.isEnabled = true
            self.isUserInteractionEnabled = true
            self.alpha = 1.0
            self.setTitleColor(color, for: .normal)
            if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}

