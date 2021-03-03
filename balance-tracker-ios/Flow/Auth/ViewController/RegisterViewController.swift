//
//  RegisterViewController.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 2.03.2021.
//
import UIKit

class RegisterViewController: BaseViewController {
    var onBack: (() -> Void)?
    var onFinishRegister: ((Bool) -> Void)?
    var onLogin: (() -> Void)?

    var viewModel: LoginViewModel!
    private let thisView: RegisterView = RegisterView()

    override func loadView() {
        super.loadView()
        self.view = thisView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.backgroundColor
        bindViewModel()
        bindActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
//        thisView.nameTextField.becomeFirstResponder()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationBarSetup()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }

    private func navigationBarSetup() {
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "info")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(didTapInfo))
    }

    @objc func didTapInfo() { }

    private func bindViewModel() {
        self.viewModel.isLoading = {(loading) in
            if loading {
                self.thisView.registerButton.loadingIndicator(true, color: .white)
            }else {
                self.thisView.registerButton.loadingIndicator(false, color: .white)
            }
        }
    }

    private func bindActions() {
        thisView.registerTapped = { (email, password) in
            self.onFinishRegister?(true)
//            self.registerAction(firstName: firstName, lastName: lastName, email: email, password: password)
//            self.registerAction(name: name, email: email, password: password)
        }
        thisView.loginTapped = {
            self.onLogin?()
        }
    }

    private func forgetPassword(_ email: String) {
//        viewModel.passwordReset(email) {
//            let alert = UIAlertController(title: "İşlem Başarılı", message: "Şifre sıfırlamak için email gönderildi.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
//            self.present(alert, animated: true)
//        } failure: { (error) in
//            self.handleError(error)
//        }
    }

//    private func registerAction(firstName: String, lastName: String, email: String, password: String) {
//        viewModel.register(email: email, password: password, firstName: firstName, lastName: lastName) {
//            self.onFinishRegister?(true)
//        } failure: { (error) in
//            self.handleError(error)
//        }
//    }

    override func didSelectCustomBackAction() {
        self.onBack?()
    }

    init(with viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

