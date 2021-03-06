//
//  BalanceViewController.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import UIKit

class BalanceViewController: BaseViewController {
    var onLogout: (() -> Void)?

    var viewModel: BalanceViewModel!

    // MARK: - Vars & Lets
    private let thisView: BalanceView = BalanceView()
    private let emptyView: FriendsView = FriendsView()

    private lazy var navContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var navTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Your Portfolio"
        return label
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass")?
                            .withRenderingMode(.alwaysOriginal) , for: .normal)
        button.setImage(UIImage(systemName: "magnifyingglass")?
                            .withRenderingMode(.alwaysOriginal)
                            .withTintColor(.systemGreen), for: .highlighted)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindActions()
        bindViewModel()
//        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    private func getAccount() {
        self.viewModel.getData {
            self.thisView.loadView(self.viewModel)
            self.viewModel.getAllPrices {
                self.thisView.loadView(self.viewModel)
            } failure: { (error) in
                self.showAlert("Error", body: error.localizedDescription)
            }

        } failure: { (error) in
            self.showAlert("Error", body: error.localizedDescription)
        }

    }

    private func setupUI() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.view.addSubview(navContainer)
        navContainer.addSubviews(navTitle, searchButton)
        navContainer.anchor(top: self.view.topAnchor,
                        leading: safeArea.leadingAnchor,
                        bottom: nil,
                        trailing: safeArea.trailingAnchor,
                        padding: .init(top: 44, left: 0, bottom: 0, right: 0),
                        size: .init(width: 0, height: 44))
        navTitle.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        navTitle.centerView(to: navContainer)
        searchButton.anchor(top: nil,
                           leading: nil,
                           bottom: nil,
                           trailing: safeArea.trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom: 0, right: 20),
                           size: .init(width: 24, height: 24))
        searchButton.centerY(to: navContainer)
        if self.account.apiKey == "-1" {
            self.view.addSubview(emptyView)
            emptyView.anchor(top: navContainer.bottomAnchor,
                            leading: safeArea.leadingAnchor,
                            bottom: safeArea.bottomAnchor,
                            trailing: safeArea.trailingAnchor,
                            padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        } else {
            self.view.addSubview(thisView)
            thisView.anchor(top: navContainer.bottomAnchor,
                            leading: safeArea.leadingAnchor,
                            bottom: safeArea.bottomAnchor,
                            trailing: safeArea.trailingAnchor,
                            padding: .init(top: 0, left: 0, bottom: 0, right: 0))
            self.getAccount()
        }
    }


    private func bindViewModel() {
        self.viewModel.isLoading = { (loading) in
            DispatchQueue.main.async {
                if loading {
                    self.showActivityIndicator()
                }else {
                    self.stopActivityIndicator()
                }
            }
        }
    }

    private func bindActions() {

    }

    private func logoutAction() {
        self.onLogout?()
    }

    @objc func handleNotifications() {}
}
