//
//  LoginView.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 2.03.2021.
//

import UIKit

class LoginView: BaseView {
    var loginTapped : ((String, String) -> Void)?
    var continueTapped : (() -> Void)?
    var forgetTapped : ((String) -> Void)?
    var registerTapped : (() -> Void)?

    lazy var brandImage: UIButton = {
        let button = UIButton()
        button.apply(style: .clearColor)
        button.backgroundColor = .white
        button.borderWidth = 0
        button.cornerRadius = 39
        button.setImage(UIImage(named: "hamurlabs"), for: .normal)
        button.setImage(UIImage(named: "hamurlabs"), for: .highlighted)
        return button
    }()
    lazy var brandTitle: UILabel = {
        let label = UILabel()
        label.apply(style: .init(font: fonts.semibold24))
        label.text = "Hamurlabs".localized()
        return label
    }()
    lazy var brandSubtitle: UILabel = {
        let label = UILabel()
        label.apply(style: .init(font: fonts.regular16))
        label.text = "Project Walker".localized()
        return label
    }()

//    lazy var containerView = UIView().createView(color: .clear, corner: 8)

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.cornerRadius = 8
        return view
    }()
    lazy var emailTextField: AppTextField = {
        let tf = AppTextField()
        tf.loadView(placeholder: "Email")
        return tf
    }()
    lazy var passwordTextField: AppTextField = {
        let tf = AppTextField()
        tf.rightViewMode = .always
        tf.loadView(placeholder: "Şifre", isSecureText: true,
                    rightViewImage: UIImage(named: "show-password")!)
        return tf
    }()
    lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "show-password"), for: .normal)
        button.addTarget(self, action: #selector(didTapShowPassword), for: .touchUpInside)
        return button
    }()
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.apply(style: .blackColor)
        button.setTitle("Üye Ol".localized(), for: .normal)
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        return button
    }()
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.apply(style: .blueColor)
        button.setTitle("Giriş Yap".localized(), for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    lazy var loginRegisterStackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 15
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    lazy var forgetLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .init(font: fonts.regular16, textColor: colors.blueTextColor))
        label.text = "Şifremi unuttum?".localized()
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(forgetButtonPressed))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(labelTap)
        return label
    }()
    lazy var continueWithoutSignIn: UIButton = {
        let button = UIButton()
        button.apply(style: .grayColor)
        button.setTitle("Giriş yapmadan devam et".localized(), for: .normal)
        button.addTarget(self, action: #selector(continueWithoutSignInButtonPressed), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupView()
        self.textFieldSetup()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView: SetupCodeView {
    func buildViewHierarchy() {
        addSubviews(brandImage, brandTitle, brandSubtitle,
                    containerView/*, continueWithoutSignIn*/)
        containerView.addSubviews(
            emailTextField,
            passwordTextField,
            loginRegisterStackView,
            forgetLabel
        )
        loginRegisterStackView.addArrangedSubview(registerButton)
        loginRegisterStackView.addArrangedSubview(loginButton)
    }

    func setupConstraints() {
        let safeArea: UILayoutGuide = self.safeAreaLayoutGuide
        brandImage.anchor(
            top: topAnchor,
            leading: nil,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 85, left: 0, bottom: 0, right: 0),
            size: .init(width: 76, height: 76)
        )
        brandImage.centerX(to: self)
        brandTitle.anchor(
            top: brandImage.bottomAnchor,
            leading: nil,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 15, left: 0, bottom: 0, right: 0)
        )
        brandTitle.centerX(to: self)
        brandSubtitle.anchor(
            top: brandTitle.bottomAnchor,
            leading: nil,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 5, left: 0, bottom: 0, right: 0)
        )
        brandSubtitle.centerX(to: self)
        containerView.anchor(
            top: brandSubtitle.bottomAnchor,
            leading: safeArea.leadingAnchor,
            bottom: nil,
            trailing: safeArea.trailingAnchor,
            padding: .init(top: 50, left: 12, bottom: 0, right: 12),
            size: .init(width: 0, height: 210)
        )
        emailTextField.anchor(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            bottom: nil,
            trailing: containerView.trailingAnchor,
            padding: .init(top: 0, left: 20, bottom: 20, right: 20),
            size: .init(width: 0, height: 45)
        )
        passwordTextField.anchor(
            top: emailTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            bottom: nil,
            trailing: containerView.trailingAnchor,
            padding: .init(top: 20, left: 20, bottom: 20, right: 20),
            size: .init(width: 0, height: 45)
        )
        loginRegisterStackView.anchor(
            top: passwordTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            bottom: nil,
            trailing: containerView.trailingAnchor,
            padding: .init(top: 20, left: 20, bottom: 0, right: 20),
            size: .init(width: 0, height: 45)
        )
        forgetLabel.anchor(
            top: loginButton.bottomAnchor,
            leading: nil,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        forgetLabel.centerX(to: self)
//        socialMediaStackView.anchor(
//            top: nil,
//            leading: leadingAnchor,
//            bottom: continueWithoutSignIn.topAnchor,
//            trailing: trailingAnchor,
//            padding: .init(top: 0, left: 32, bottom: 40, right: 32),
//            size: .init(width: 0, height: 90)
//        )
//        continueWithoutSignIn.anchor(
//            top: nil,
//            leading: leadingAnchor,
//            bottom: safeArea.bottomAnchor,
//            trailing: trailingAnchor,
//            padding: .init(top: 0, left: 32, bottom: 10, right: 32),
//            size: .init(width: 0, height: 45)
//        )

    }

    func setupAdditionalConfiguration() {
        //        self.backgroundColor = UIColor(rgba: "#F9F9F9")
    }
}

extension LoginView {
    @objc func loginButtonPressed(){
        if !checkTextField(emailTextField, validationType: .email) ||
            !checkTextField(passwordTextField, validationType: .password) {
            return
        }
        if let email = emailTextField.text, let password = passwordTextField.text {
            self.loginTapped?(email, password)
        }
    }
    @objc func forgetButtonPressed(){
        if let email = emailTextField.text{
            self.forgetTapped?(email)
        }
    }
    @objc func continueWithoutSignInButtonPressed(){
        self.continueTapped?()
    }
    @objc func registerButtonPressed(){
        self.registerTapped?()
    }

    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        if textField.text?.isValidEmail ?? false {
            emailTextField.rightViewMode = .always
            let imageview = UIImageView(frame: .init(x: 0, y: 0, width: 20, height: 20))
            imageview.image = UIImage(named: "check")
            imageview.contentMode = .right
            emailTextField.rightView = imageview
        } else {
            emailTextField.rightViewMode = .never
        }
    }
    @objc func didTapShowPassword() {
        if passwordTextField.isSecureTextEntry {
            showPasswordButton.setImage(UIImage(named: "hide-password"), for: .normal)
        } else {
            showPasswordButton.setImage(UIImage(named: "show-password"), for: .normal)
        }
        passwordTextField.isSecureTextEntry.toggle()
    }

    private func textFieldSetup() {
        passwordTextField.rightView = showPasswordButton
        emailTextField.textFieldChanged = { [unowned self](text) in
            if text.isValidEmail {
                self.emailTextField.rightViewMode = .always
                let imageview = UIImageView(frame: .init(x: 0, y: 0, width: 20, height: 20))
                imageview.image = UIImage(named: "check")
                imageview.contentMode = .right
                self.emailTextField.rightView = imageview
            } else {
                self.emailTextField.rightViewMode = .never
            }
        }
    }
}
