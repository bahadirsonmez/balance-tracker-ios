//
//  AccountView.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 20.02.2021.
//
import UIKit

class AccountView: UIView {

    var safeArea = UILayoutGuide()
//    let minLineSpacing = Constants.BasicCell.minLineSpacing
//    let cellHeight = Constants.BasicCell.cellHeight
//    let headerHeight = Constants.HeaderSize.profileHeader.height
//    let sectionInset = Constants.BasicCell.sectionInset
//    let sectionInsetZero = Constants.BasicCell.sectionInsetZero
    let cellId = "cellId"
    let headerId = "headerId"

    var rowTapped : ((Int) -> Void)?

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
//        cv.backgroundColor = Constants.Colors.backgroundColor
        return cv
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")

    }
}

extension AccountView: SetupCodeView {
    func buildViewHierarchy() {
        self.addSubviews(collectionView)
    }

    func setupConstraints() {
        safeArea = self.safeAreaLayoutGuide
        collectionView.anchor(top: safeArea.topAnchor,
                              leading: safeArea.leadingAnchor,
                              bottom: safeArea.bottomAnchor,
                              trailing: safeArea.trailingAnchor
                              )
    }

    func setupAdditionalConfiguration() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BasicCell.self,
                                forCellWithReuseIdentifier: cellId)
    }
}

extension AccountView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                      for: indexPath) as!  BasicCell
//        cell.setupCell(
//            Constants.CellTitles.menuTitles[indexPath.row],
//            menuImageName: Constants.CellImages.menuImages[indexPath.row]
//        )
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.rowTapped?(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32,
                      height: 200)
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
