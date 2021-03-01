//
//  BasicHeader.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//

import UIKit

class BasicHeader: UICollectionReusableView {
    lazy var label: UILabel = {
        let label: UILabel = UILabel()
//        label.textColor = Constants.Colors.dimmedText
//        label.font = Constants.Fonts.font0bn
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        addSubview(label)
//        let padding = Constants.BasicCell.padding
        label.anchor(top: nil,
                     leading: self.leadingAnchor,
                     bottom: nil,
                     trailing: nil,
                     padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
