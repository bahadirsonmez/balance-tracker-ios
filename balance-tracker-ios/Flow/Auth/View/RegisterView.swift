//
//  RegisterView.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 2.03.2021.
//
import UIKit

class RegisterView: BaseView {
    var registerTapped : ((String, String) -> Void)?
    var loginTapped: (() -> Void)?
    var privacyTapped : (() -> Void)?

    lazy var formContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .clear
        view.contentMode = .top
        return view
    }()
    lazy var emailTextField: AppTextField = {
        let tf = AppTextField()
        tf.loadView(placeholder: "Email")
        tf.text = "bahadir@gmail.com"
        return tf
    }()
    lazy var passwordTextField: AppTextField = {
        let tf = AppTextField()
        tf.rightViewMode = .always
        tf.loadView(placeholder: "Password", isSecureText: true,
                    rightViewImage: UIImage(named: "show-password")!)
        tf.text = "123456"
        return tf
    }()
    lazy var confirmPasswordTextField: AppTextField = {
        let tf = AppTextField()
        tf.rightViewMode = .always
        tf.loadView(placeholder: "Confirm Password", isSecureText: true,
                    rightViewImage: UIImage(named: "show-password")!)
        tf.text = "123456"
        return tf
    }()
    lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "show-password"), for: .normal)
        button.addTarget(self, action: #selector(didTapShowPassword), for: .touchUpInside)
        return button
    }()
    lazy var showConfirmPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "show-password"), for: .normal)
        button.addTarget(self, action: #selector(didTapShowConfirmPassword), for: .touchUpInside)
        return button
    }()
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.apply(style: .blueColor)
        button.setTitle("Create an Account".localized(), for: .normal)
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        return button
    }()
    lazy var alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton()
        button.apply(style: .grayColor)
        button.setTitle("I have an account".localized(), for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
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

extension RegisterView: SetupCodeView {
    func buildViewHierarchy() {
        addSubviews(formContainerView, alreadyHaveAnAccountButton)
        formContainerView.addSubviews(
            emailTextField,
            passwordTextField,
            confirmPasswordTextField,
            registerButton)
    }

    func setupConstraints() {
        let safeArea: UILayoutGuide = self.safeAreaLayoutGuide
        formContainerView.anchor(
            top: safeArea.topAnchor,
            leading: safeArea.leadingAnchor,
            bottom: nil,
            trailing: safeArea.trailingAnchor,
            padding: .init(top: 20, left: 12, bottom: 0, right: 12),
            size: .init(width: 0, height: 460)
        )
        emailTextField.anchor(
            top: formContainerView.topAnchor,
            leading: formContainerView.leadingAnchor,
            bottom: nil,
            trailing: formContainerView.trailingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: 20),
            size: .init(width: 0, height: 45)
        )
        passwordTextField.anchor(
            top: emailTextField.bottomAnchor,
            leading: formContainerView.leadingAnchor,
            bottom: nil,
            trailing: formContainerView.trailingAnchor,
            padding: .init(top: 20, left: 20, bottom: 20, right: 20),
            size: .init(width: 0, height: 45)
        )
        confirmPasswordTextField.anchor(
            top: passwordTextField.bottomAnchor,
            leading: formContainerView.leadingAnchor,
            bottom: nil,
            trailing: formContainerView.trailingAnchor,
            padding: .init(top: 20, left: 20, bottom: 20, right: 20),
            size: .init(width: 0, height: 45)
        )
        registerButton.anchor(
            top: confirmPasswordTextField.bottomAnchor,
            leading: formContainerView.leadingAnchor,
            bottom: nil,
            trailing: formContainerView.trailingAnchor,
            padding: .init(top: 20, left: 20, bottom: 0, right: 20),
            size: .init(width: 0, height: 45)
        )
        alreadyHaveAnAccountButton.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: safeArea.bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 32, bottom: 10, right: 32),
            size: .init(width: 0, height: 45)
        )
    }

    func setupAdditionalConfiguration() {
    }
}

extension RegisterView {
    @objc func registerButtonPressed(){
        if !checkTextField(emailTextField, validationType: .email) ||
           !checkTextField(passwordTextField, validationType: .password) {
            return
        }
        if passwordTextField.text != confirmPasswordTextField.text {
            confirmPasswordTextField.shake()
            confirmPasswordTextField.text = ""
            confirmPasswordTextField.attributedPlaceholder = NSAttributedString.init(string: "Lütfen parolayı doğru giriniz".localized(), attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            return
        }
        if let email = emailTextField.text, let password = passwordTextField.text {
            self.registerTapped?(email, password)
        }
    }
    @objc func loginButtonPressed(){
        self.loginTapped?()
    }

    @objc func privacyButtonPressed(){
        self.privacyTapped?()
    }
    private func textFieldSetup() {
        passwordTextField.rightView = showPasswordButton
        confirmPasswordTextField.rightView = showConfirmPasswordButton
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
    @objc func didTapShowPassword() {
        if passwordTextField.isSecureTextEntry {
            showPasswordButton.setImage(UIImage(named: "hide-password"), for: .normal)
        } else {
            showPasswordButton.setImage(UIImage(named: "show-password"), for: .normal)
        }
        passwordTextField.isSecureTextEntry.toggle()
    }

    @objc func didTapShowConfirmPassword() {
        if confirmPasswordTextField.isSecureTextEntry {
            showConfirmPasswordButton.setImage(UIImage(named: "hide-password"), for: .normal)
        } else {
            showConfirmPasswordButton.setImage(UIImage(named: "show-password"), for: .normal)
        }
        confirmPasswordTextField.isSecureTextEntry.toggle()
    }
}
