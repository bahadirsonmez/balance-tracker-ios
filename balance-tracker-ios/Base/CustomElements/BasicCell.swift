//
//  BasicCell.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import UIKit

class BasicCell: BaseCell {
    
    private lazy var cellIconLeft : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.backgroundColor = colors.gray30
        image.cornerRadius = 25
        return image
    }()

    private lazy var cellTitle: UILabel = {
        let label = UILabel()
        label.apply(style: .init())
        return label
    }()

    private lazy var cellSubtitle: UILabel = {
        let label = UILabel()
        label.apply(style: .init())
        return label
    }()

    private lazy var cellIconRight : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Arrow Right")
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private lazy var cellSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = colors.gray30
        return view
    }()

    override func setupViews() {
        setupView()
    }

    public func setupCell(with model: FriendItem) {
        self.cellTitle.text = model.name
        cellTitle.centerY(to: self)
    }

    public func setupCell(_ title: String, subTitle: String = "", tickHidden: Bool = true, imageName: String = "", rightTitle: String = "") {
        cellIconLeft.image = UIImage(named: imageName)
        cellTitle.text = title
        cellSubtitle.text = subTitle
    }
}

extension BasicCell : SetupCodeView {
    func buildViewHierarchy() {
        self.contentView.addSubviews(
            cellIconLeft,
            cellTitle,
            cellSubtitle,
            cellIconRight,
            cellSeperator
        )
    }

    func setupConstraints() {
        cellIconLeft.anchor(
            leading: self.leadingAnchor,
            padding: .init(top: 0, left: 20, bottom: 0, right: 0),
            size: .init(width: 50, height: 50)
        )
        cellIconLeft.centerY(to: self)
        cellTitle.anchor(
            top: cellIconLeft.topAnchor,
            leading: cellIconLeft.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 0, right: 0)
        )
        cellSubtitle.anchor(
            top: cellTitle.bottomAnchor,
            leading: cellIconLeft.trailingAnchor,
            padding: .init(top: 5, left: 10, bottom: 0, right: 0)
        )
        cellIconRight.anchor(
            trailing: self.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 20)
        )
        cellIconRight.centerY(to: self)
        cellSeperator.anchor(
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
    }

    func setupAdditionalConfiguration() {

    }
}
