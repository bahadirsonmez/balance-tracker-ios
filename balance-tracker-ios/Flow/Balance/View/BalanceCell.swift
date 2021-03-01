//
//  CoinListView.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 21.02.2021.
//

import UIKit

class BalanceCell: BaseCell {
    private lazy var coinIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.cornerRadius = 25
        return iv
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .init(font: font.semibold24))
        label.text = "XRP"
        return label
    }()
    private lazy var totalHoldingsLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .init())
        label.text = "$1.042\n1.900"
        return label
    }()
    private lazy var seperator: UIView = {
        let view = UIView()
        view.backgroundColor = colors.gray30
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not veen implemented")
    }

    func setupCell(with item: AccountBalance) {
        self.coinIcon.image = UIImage(named: "\(item.asset.lowercased())") ?? UIImage(named: "crypto-coin")?.withTintColor(.random())
        self.titleLabel.text = item.asset
        self.totalHoldingsLabel.text = "\(item.totalAmount)"
    }
}

extension BalanceCell: SetupCodeView {
    func buildViewHierarchy() {
        addSubviews(coinIcon, titleLabel, totalHoldingsLabel, seperator)
    }

    func setupConstraints() {
        coinIcon.anchor(
            leading: leadingAnchor,
            padding: .init(top: 0, left: 15, bottom: 0, right: 0),
            size: .init(width: 50, height: 50)
        )
        coinIcon.centerY(to: self)
        titleLabel.anchor(
            leading: coinIcon.trailingAnchor,
            padding: .init(top: 0, left: 10, bottom: 0, right: 0)
        )
        titleLabel.centerY(to: self)
        totalHoldingsLabel.anchor(
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 15)
        )
        totalHoldingsLabel.centerY(to: self)
        seperator.anchor(
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            size: .init(width: 0, height: 1)
        )
    }

    func setupAdditionalConfiguration() {
    }
}
