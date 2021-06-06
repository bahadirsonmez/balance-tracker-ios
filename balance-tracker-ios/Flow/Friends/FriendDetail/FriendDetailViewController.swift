//
//  FriendDetailViewController.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.03.2021.
//
import UIKit

class FriendDetailViewController: BaseViewController {
    var onBack: (() -> Void)?

    var viewModel: FriendsViewModel!
    var item: FriendItem!

    // MARK: - Vars & Lets
    private let thisView: FriendDetailView = FriendDetailView()
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
        label.text = "\(self.item.name!)'s Portfolio"
        return label
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back-arrow-black"), for: .normal)
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindActions()
        bindViewModel()
        setupUI()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.getAccount()
    }

    private func getAccount() {
        self.viewModel.getFriendBalanceDetail(self.item) {
            self.thisView.loadView(with: self.item, viewModel: self.viewModel)
        } failure: { (error) in
            self.showAlert("Error", body: error.localizedDescription)
        }
    }


    private func setupUI() {
        let safeArea = self.view.safeAreaLayoutGuide
        view.addSubviews(navContainer, thisView)
        navContainer.addSubviews(navTitle, backButton)
        navContainer.anchor(
            top: view.topAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            padding: .init(top: 44, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 44)
        )
        backButton.anchor(
            leading: navContainer.leadingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: 0),
            size: .init(width: 20, height: 20)
        )
        backButton.centerY(to: navContainer)
        navTitle.centerView(to: navContainer)
        thisView.anchor(
            top: navContainer.bottomAnchor,
            leading: safeArea.leadingAnchor,
            bottom: safeArea.bottomAnchor,
            trailing: safeArea.trailingAnchor
        )
    }

    private func bindActions() {

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


    @objc func didTapBack(_ sender: UIButton) {
        self.onBack?()
    }

}
