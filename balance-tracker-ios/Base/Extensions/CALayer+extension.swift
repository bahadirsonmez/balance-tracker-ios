//
//  CALayer+extension.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 18.02.2021.
//
import UIKit

extension CALayer {
    func applySketchShadow(color: UIColor = .black,
                            alpha: Float = 0.2,
                            x: CGFloat = 0,
                            y: CGFloat = 16,
                            blur: CGFloat = 16,
                            spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }

    func applyButtonShadow(_ spread: CGFloat = 0) {
        let color = UIColor.black
//        let spread = 0
        let x = 0
        let y = 16
        let opacity = 0.08
        shadowColor = color.cgColor
        shadowOpacity = Float(opacity)
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = 16 / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: CGFloat(dx), dy: CGFloat(dx))
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
