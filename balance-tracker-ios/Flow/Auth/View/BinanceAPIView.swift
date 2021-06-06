//
//  BinanceAPIView.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 5.03.2021.
//
import UIKit

class BinanceAPIView: BaseView {
    var submitTapped : ((String, String) -> Void)?
    var skipTapped: (() -> Void)?

    lazy var formContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .clear
        view.contentMode = .top
        return view
    }()
    lazy var apiKeyTextField: AppTextField = {
        let tf = AppTextField()
        tf.loadView(placeholder: "API Key")
        tf.text = "AHYsxSFQXzlCeoByVELgCQes6xo7oYV5pLYtl03udOcNkpI8C3W8JtwrKJPLmD1x"
        return tf
    }()
    lazy var secretKeyTextField: AppTextField = {
        let tf = AppTextField()
        tf.loadView(placeholder: "Secret Key")
        tf.text = "KZbsaybbUFTLPvXFbwzwIOk6VVs7kNr4TIvMD7OifzLAgTNAruLeB0xcpLHnVxN8"
        return tf
    }()
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.apply(style: .blueColor)
        button.setTitle("Submit".localized(), for: .normal)
        button.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        return button
    }()
    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.apply(style: .grayColor)
        button.setTitle("Skip Now".localized(), for: .normal)
        button.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")
    }
}

extension BinanceAPIView: SetupCodeView {
    func buildViewHierarchy() {
        addSubviews(formContainerView, skipButton)
        formContainerView.addSubviews(
            apiKeyTextField,
            secretKeyTextField,
            submitButton)
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
        apiKeyTextField.anchor(
            top: formContainerView.topAnchor,
            leading: formContainerView.leadingAnchor,
            bottom: nil,
            trailing: formContainerView.trailingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: 20),
            size: .init(width: 0, height: 45)
        )
        secretKeyTextField.anchor(
            top: apiKeyTextField.bottomAnchor,
            leading: formContainerView.leadingAnchor,
            bottom: nil,
            trailing: formContainerView.trailingAnchor,
            padding: .init(top: 20, left: 20, bottom: 20, right: 20),
            size: .init(width: 0, height: 45)
        )
        submitButton.anchor(
            top: secretKeyTextField.bottomAnchor,
            leading: formContainerView.leadingAnchor,
            bottom: nil,
            trailing: formContainerView.trailingAnchor,
            padding: .init(top: 20, left: 20, bottom: 0, right: 20),
            size: .init(width: 0, height: 45)
        )
        skipButton.anchor(
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

extension BinanceAPIView {
    @objc func submitButtonPressed(){
        if let apiKey = apiKeyTextField.text, let secretKey = secretKeyTextField.text {
            self.submitTapped?(apiKey, secretKey)
        }
    }
    @objc func skipButtonPressed(){
        self.skipTapped?()
    }
}
