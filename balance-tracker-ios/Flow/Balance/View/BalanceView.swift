//
//  BalanceView.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import UIKit

class BalanceView: UIView {
    var viewModel: BalanceViewModel!

    var safeArea = UILayoutGuide()
    let cellId = "cellId"
    let headerId = "headerId"

    var rowTapped : ((Int) -> Void)?

    lazy var chartView: DonutChartView = {
        let view = DonutChartView()
        return view
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = Constants.Colors.backgroundColor
        return cv
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")

    }

    func loadView(_ vm: BalanceViewModel) {
        self.viewModel = vm
        DispatchQueue.main.async {
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.register(BalanceCell.self,
                                         forCellWithReuseIdentifier: self.cellId)
            self.collectionView.register(BalanceHeader.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: self.headerId)
            self.collectionView.reloadData()
            self.chartView.loadView(with: self.viewModel)
        }
    }
}

extension BalanceView: SetupCodeView {
    func buildViewHierarchy() {
        self.addSubviews(chartView, collectionView)
    }

    func setupConstraints() {
        safeArea = self.safeAreaLayoutGuide
        chartView.anchor(
            top: safeArea.topAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 0),
            size: .init(width: 350, height: 350)
        )
        chartView.centerX(to: self)
        collectionView.anchor(
            top: chartView.bottomAnchor,
            leading: safeArea.leadingAnchor,
            bottom: safeArea.bottomAnchor,
            trailing: safeArea.trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 0)
        )
    }

    func setupAdditionalConfiguration() {

    }
}

extension BalanceView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                      for: indexPath) as!  BalanceCell
        cell.setupCell(with: (viewModel.binanceBalances[indexPath.row]))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.rowTapped?(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20,
                      height: 70)
    }

    // MARK: - CollectionView Header
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: headerId,
                                                                             for: indexPath)  as! BalanceHeader
            return headerView
        default:
            fatalError("Unexpected element kind")
        }
    }


    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
}
