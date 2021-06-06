//
//  FriendsView.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 20.02.2021.
//
import UIKit

class FriendsView: UIView {
    var addButtonTapped: (() -> Void)? = nil
    var safeArea = UILayoutGuide()
    let cellId = "cellId"
    var viewModel: FriendsViewModel!
    var rowTapped : ((FriendItem) -> Void)?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        return cv
    }()

    private lazy var addFriendButton: UIButton = {
        let button = UIButton()
        button.apply(style: .orangeColor)
        button.setTitle("Add Friend", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    @objc func didTapButton(_ sender: UIButton) {

    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupView()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")

    }

    func loadView(with viewModel: FriendsViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

extension FriendsView: SetupCodeView {
    func buildViewHierarchy() {
        self.addSubviews(collectionView, addFriendButton)
    }

    func setupConstraints() {
        safeArea = self.safeAreaLayoutGuide
        collectionView.anchor(
            top: safeArea.topAnchor,
            leading: safeArea.leadingAnchor,
            bottom: addFriendButton.topAnchor,
            trailing: safeArea.trailingAnchor
        )
        addFriendButton.anchor(
            top: collectionView.bottomAnchor,
            leading: safeArea.leadingAnchor,
            bottom: safeArea.bottomAnchor,
            trailing: safeArea.trailingAnchor,
            padding: .init(top: 10, left: 20, bottom: 20, right: 20),
            size: .init(width: 0, height: 45)
        )
    }

    func setupAdditionalConfiguration() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BasicCell.self,
                                forCellWithReuseIdentifier: cellId)
    }
}

extension FriendsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfFriends
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                      for: indexPath) as!  BasicCell
        cell.setupCell(with: self.viewModel.friendItems[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.rowTapped?(self.viewModel.friendItems[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: 60)
    }

//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInset
//    }

//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return minLineSpacing
//    }
}
