//
//  BaseView.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//

import UIKit

class BaseView: UIView {
    let account = KeychainAccount.sharedAccount
    let fonts = Constants.Fonts.self
    let colors = Constants.Colors.self
    let shadow = Constants.Shadow.self
    let texts = Constants.Texts.self

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        hideKeyboardWhenTappedAround()
        backgroundColor = .clear
    }

    func setupViews() {

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not veen implemented")
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        endEditing(true)
    }

    func checkTextField(_ textField: UITextField, validationType: ValidatorType) -> Bool {
        do {
            try textField.validatedText(validationType)
        } catch {
            let validationError = error as! ValidationError
            textField.text = ""
            textField.attributedPlaceholder = NSAttributedString.init(string: validationError.localizedDescription, attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            return false
        }
        return true
    }

    func fadeInAndOutAnimator(_ views: UIView..., duration: Double, action: @escaping () -> Void) {
        UIView.animate(withDuration: duration) {
            views.forEach {
                $0.alpha = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+duration) {
            action()
            UIView.animate(withDuration: duration) {
                views.forEach {
                    $0.alpha = 1
                }
            }
        }
    }

}
