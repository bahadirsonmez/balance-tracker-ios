//
//  ProfileViewController.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 20.02.2021.
//
import UIKit

class ProfileViewController: BaseViewController {
    var onLogout: (() -> Void)?

    var viewModel: ProfileViewModel!

    // MARK: - Vars & Lets
    private let thisView: ProfileView = ProfileView()
    private lazy var navContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var navTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//        label.textColor = Constants.Colors.mainTextColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Welcome"
        return label
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Search"), for: .normal)
        return button
    }()

    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Filter"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.navigationBar.isHidden = false
    }

    private func setupUI() {
        let safeArea = self.view.safeAreaLayoutGuide
        self.view.addSubview(navContainer)
        navContainer.addSubviews(navTitle, searchButton, filterButton)
        self.view.addSubview(thisView)
        navContainer.anchor(top: self.view.topAnchor,
                        leading: safeArea.leadingAnchor,
                        bottom: nil,
                        trailing: safeArea.trailingAnchor,
                        padding: .init(top: 44, left: 0, bottom: 0, right: 0),
                        size: .init(width: 0, height: 44))
        navTitle.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        navTitle.centerView(to: navContainer)
        filterButton.anchor(top: nil,
                           leading: nil,
                           bottom: nil,
                           trailing: searchButton.leadingAnchor,
                           padding: .init(top: 0, left: 0, bottom: 0, right: 20),
                           size: .init(width: 24, height: 24))
        filterButton.centerY(to: searchButton)
        searchButton.anchor(top: nil,
                           leading: nil,
                           bottom: nil,
                           trailing: safeArea.trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom: 0, right: 20),
                           size: .init(width: 24, height: 24))
        searchButton.centerY(to: navContainer)
        thisView.anchor(top: navContainer.bottomAnchor,
                        leading: safeArea.leadingAnchor,
                        bottom: safeArea.bottomAnchor,
                        trailing: safeArea.trailingAnchor,
                        padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }

    private func bindActions() {

    }

    private func logoutAction() {
        self.onLogout?()
    }

    @objc func handleNotifications() {}
}
