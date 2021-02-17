//
//  BaseCell.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 17.02.2021.
//
import UIKit

class BaseCell: UICollectionViewCell {
//    let font = Constants.Fonts.self
//    let colors = Constants.Colors.self
//    let buttonTitle = Constants.ButtonTitles.self
//    let constraint = Constants.Constraints.self
//    let shadow = Constants.Shadows.self

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
