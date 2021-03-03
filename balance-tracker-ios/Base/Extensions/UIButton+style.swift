//
//  UIButton+style.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 3.03.2021.
//
import UIKit

extension UIButton {

    struct Style {
        let backgroundColor: UIColor?
        let tintColor: UIColor
        let titleColor: UIColor
        let titleFont: UIFont
        let borderColor: UIColor?
        let borderWidth: CGFloat
        let cornerRadius: CGFloat

        init(backgroundColor: UIColor?, tintColor: UIColor, titleColor: UIColor,
             titleFont: UIFont, borderColor: UIColor?, borderWidth: CGFloat, cornerRadius: CGFloat) {
            self.backgroundColor = backgroundColor
            self.tintColor = tintColor
            self.titleColor = titleColor
            self.titleFont = titleFont
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.cornerRadius = cornerRadius
        }
    }
}

extension UIButton.Style {
    static var grayColor: UIButton.Style {
        return UIButton.Style(backgroundColor: Constants.Colors.gray,
                              tintColor: Constants.Colors.gray,
                              titleColor: Constants.Colors.mainTextColor,
                              titleFont: Constants.Fonts.medium17,
                              borderColor: .clear,
                              borderWidth: 0.0,
                              cornerRadius: 6.0)
    }
    static var blueColor: UIButton.Style {
        return UIButton.Style(backgroundColor: Constants.Colors.blueTextColor,
                              tintColor: Constants.Colors.blueTextColor,
                              titleColor: UIColor.white,
                              titleFont: Constants.Fonts.medium17,
                              borderColor: .clear,
                              borderWidth: 0.0,
                              cornerRadius: 6.0)
    }
    static var blackColor: UIButton.Style {
        return UIButton.Style(backgroundColor: Constants.Colors.mainTextColor,
                              tintColor: Constants.Colors.mainTextColor,
                              titleColor: UIColor.white,
                              titleFont: Constants.Fonts.medium17,
                              borderColor: Constants.Colors.mainTextColor,
                              borderWidth: 0.0,
                              cornerRadius: 6.0)
    }
    static var orangeColor: UIButton.Style {
        return UIButton.Style(backgroundColor: Constants.Colors.orangeColor,
                              tintColor: Constants.Colors.orangeColor,
                              titleColor: UIColor.white,
                              titleFont: Constants.Fonts.medium17,
                              borderColor: Constants.Colors.orangeColor,
                              borderWidth: 0.0,
                              cornerRadius: 6.0)
    }

    static var clearColor: UIButton.Style {
        return UIButton.Style(backgroundColor: .clear,
                              tintColor: Constants.Colors.gray,
                              titleColor: Constants.Colors.mainTextColor,
                              titleFont: Constants.Fonts.medium17,
                              borderColor: Constants.Colors.grayButtonBorder,
                              borderWidth: 1.0,
                              cornerRadius: 6.0)
    }

}

extension UIButton {
    func apply(style: Style) {
        backgroundColor = style.backgroundColor
        tintColor = style.tintColor
        titleLabel?.font = style.titleFont

        setTitleColor(style.titleColor, for: .normal)

        layer.borderColor = style.borderColor?.cgColor
        layer.borderWidth = style.borderWidth
        layer.cornerRadius = style.cornerRadius
        // MARK: - Gölgeler kaldırıldı
//        layer.applyButtonShadow()
        translatesAutoresizingMaskIntoConstraints = false
    }
}
