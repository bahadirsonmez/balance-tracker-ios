//
//  AppTextField.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 2.03.2021.
//
import UIKit

class AppTextField: UITextField {
    var textFieldChanged: ((String) -> Void)?
    var rightViewTapped: (() -> Void)?

    var textPadding = UIEdgeInsets(
        top: 10,
        left: 20,
        bottom: 10,
        right: 20
    )
    var rightViewPadding = UIEdgeInsets(
        top: 0,
        left: -20,
        bottom: 0,
        right: 20
    )

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.inset(by: rightViewPadding)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = UIColor(rgba: "#F2F3F7")
        cornerRadius = 6
        clipsToBounds = true
        font = Constants.Fonts.regular16
        textColor = Constants.Colors.mainTextColor
        textAlignment = .left
        contentHorizontalAlignment = .center
        autocapitalizationType = .none
        autocorrectionType = .no
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        rightViewSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadView(placeholder: String, isSecureText: Bool = false, rightViewImage: UIImage = UIImage()) {
        let color = UIColor(rgba: "#A1A4B2")
        let placeholder = placeholder
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
        isSecureTextEntry = isSecureText
        rightViewSetup()
    }

    private func rightViewSetup(image: UIImage = UIImage()) {
        let view = UIView(frame: .init(x: 0, y: 0, width: 20, height: 20))
        let iv = UIImageView(image: image)
        iv.contentMode = .scaleAspectFit
        view.addSubview(iv)
        iv.fillSuperview()
        rightView = view
        rightView?.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didTapRightView)))
    }
}

extension AppTextField {
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textFieldChanged?(text ?? "")
//        self.textFieldChanged?(textField.text ?? "")
    }

    @objc func didTapRightView() {
        self.rightViewTapped?()
    }
}
