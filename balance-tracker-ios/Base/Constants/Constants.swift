//
//  Constants.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import  UIKit

struct Constants {
    struct Colors {
        static let barTintColor = UIColor.systemBlue

        // View Background Color
        static let backgroundColor = UIColor.white

        // Gray color
        static let gray = UIColor(rgba: "#F6F6F6")
        static let gray30 = UIColor(rgba: "#D0D0D0")
        static let grayButtonBorder = UIColor(rgba: "#E6E6E7")

        static let orangeColor = UIColor(rgba: "#FFA601")

        // Text Colors
        static let mainTextColor = UIColor(rgba: "#2D2D2F")
        static let secondaryTextColor = UIColor(rgba: "#8D8D8E")
        static let blueTextColor = UIColor(rgba: "#2967FF")
    }

    struct Fonts {
        static let light14: UIFont = UIFont.systemFont(ofSize: 14, weight: .light)
        static let light16: UIFont = UIFont.systemFont(ofSize: 14, weight: .light)
        static let regular13: UIFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        static let regular14: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let regular16: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let medium10: UIFont = UIFont.systemFont(ofSize: 10, weight: .medium)
        static let medium12: UIFont = UIFont.systemFont(ofSize: 12, weight: .medium)
        static let medium14: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let medium17: UIFont = UIFont.systemFont(ofSize: 17, weight: .medium)
        static let medium32: UIFont = UIFont.systemFont(ofSize: 32, weight: .medium)
        static let semibold24: UIFont = UIFont.systemFont(ofSize: 24, weight: .semibold)
        static let bold10: UIFont = UIFont.systemFont(ofSize: 10, weight: .bold)
        static let bold14: UIFont = UIFont.systemFont(ofSize: 14, weight: .bold)
        static let bold18: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let bold20: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let bold24: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        static let bold30: UIFont = UIFont.systemFont(ofSize: 30, weight: .bold)
        static let bold32: UIFont = UIFont.systemFont(ofSize: 32, weight: .bold)
    }

    struct Shadow {

    }

    struct Size {
        
    }

    struct Tab {
        static let tab0Title = "".localized()
        static let tab1Title = "".localized()
        static let tab2Title = "".localized()


        static let tab0 = UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(Constants.Colors.gray30)
        static let tab0Selected = UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(Constants.Colors.mainTextColor)

        static let tab1 = UIImage(systemName: "banknote.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(Constants.Colors.gray30)
        static let tab1Selected = UIImage(systemName: "banknote.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(Constants.Colors.mainTextColor)

        static let tab2 = UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(Constants.Colors.gray30)
        static let tab2Selected = UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(Constants.Colors.mainTextColor)
    }

}
