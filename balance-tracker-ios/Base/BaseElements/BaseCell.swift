//
//  BaseCell.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
import UIKit

class BaseCell: UICollectionViewCell {
    let font = Constants.Fonts.self
    let colors = Constants.Colors.self
    let shadow = Constants.Shadow.self

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not veen implemented")
    }
}

class BaseHeader: UICollectionReusableView {
    let font = Constants.Fonts.self
    let colors = Constants.Colors.self
    let shadow = Constants.Shadow.self

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not veen implemented")
    }
}
