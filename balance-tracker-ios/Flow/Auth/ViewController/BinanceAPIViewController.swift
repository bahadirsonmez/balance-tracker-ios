//
//  BinanceAPIViewController.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 5.03.2021.
//
import UIKit

class BinanceAPIViewController: BaseViewController {
    var onBack: (() -> Void)?
    var onContinue: (() -> Void)?

    var viewModel: LoginViewModel!
    private let thisView: BinanceAPIView = BinanceAPIView()

    init(with viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        super.loadView()
        self.view = thisView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors.backgroundColor
        self.title = "Binance API Setup"
        bindViewModel()
        bindActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
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
            DispatchQueue.main.async {
                if loading {
                    self.thisView.submitButton.loadingIndicator(true, color: .white)
                }else {
                    self.thisView.submitButton.loadingIndicator(false, color: .white)
                }
            }
        }
    }

    private func bindActions() {
        thisView.submitTapped = { (apiKey, secretKey) in
            self.viewModel.checkAPIandSecret(apiKey: apiKey, secretKey: secretKey) {
                DispatchQueue.main.async {
                    self.onContinue?()
                }
            } failure: { (error) in
                self.showAlert("Error", message: error.localizedDescription)
            }
        }
        thisView.skipTapped = {
            self.account.setApiKey("-1")
            self.account.setSecretKey("-1")
            self.onContinue?()
        }
    }

    override func didSelectCustomBackAction() {
        self.onBack?()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

