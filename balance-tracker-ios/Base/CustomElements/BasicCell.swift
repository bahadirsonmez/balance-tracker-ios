//
//  BasicCell.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 19.02.2021.
//
import UIKit

class BasicCell: BaseCell {
    var isPaymentCell: Bool = false

    lazy var cellIconLeft : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var cellTitle: UILabel = {
        let label = UILabel()
//        label.font = Constants.Fonts.fontN1b
//        label.textColor = Constants.Colors.mainTextColor
        label.addInterlineSpacing(spacingValue: 4, alignment: .left)
        return label
    }()

    lazy var cellSubtitle: UILabel = {
        let label = UILabel()
//        label.font = Constants.Fonts.fontN1
//        label.textColor = Constants.Colors.dimmedText
        label.addInterlineSpacing(spacingValue: 4, alignment: .left)
        return label
    }()

    lazy var cellRightTitle: UILabel = {
        let label = UILabel()
//        label.font = Constants.Fonts.fontN1
//        label.textColor = Constants.Colors.dimmedText
        label.addInterlineSpacing(spacingValue: 4, alignment: .left)
        return label
    }()

    lazy var cellInnerIcon : UIImageView = {
        let imageView = UIImageView()
//        imageView.image = Constants.BasicCell.tickIcon
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()

    lazy var cellIconRight : UIImageView = {
        let iv = UIImageView()
//        iv.image = Constants.BasicCell.nextImage
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    lazy var cellSeperator: UIView = {
        let view = UIView()
//        view.backgroundColor = Constants.Colors.softBG
        return view
    }()

    override func setupViews() {
        setupView()
    }

    public func setupCell(_ title: String, _ subTitle: String, _ tickHidden: Bool, _ imageName: String, _ rightTitle: String, _ isPaymentCell: Bool = false) {
        cellIconLeft.image = UIImage(named: imageName)
        cellTitle.text = title
        cellSubtitle.text = subTitle
        cellRightTitle.text = rightTitle
        cellInnerIcon.isHidden = tickHidden
    }
}

extension BasicCell : SetupCodeView {
    func buildViewHierarchy() {
        self.contentView.addSubviews(cellIconLeft,
                         cellTitle, cellSubtitle,
                         cellInnerIcon, cellIconRight,
                         cellRightTitle, cellSeperator)
    }

    func setupConstraints() {
//        let padding = Constants.BasicCell.padding
//        let leftCellSize = Constants.BasicCell.leftCellIcon
//        let innerCellSize = Constants.BasicCell.innerCellIcon
//        let rightCellSize = Constants.BasicCell.rightCellIcon
//        let seperatorSize = Constants.BasicCell.seperator
        cellIconLeft.anchor(top: self.topAnchor,
                         leading: self.leadingAnchor,
                         bottom: nil, trailing: nil,
                         padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
        cellTitle.anchor(top: nil,
                          leading: self.leadingAnchor,
                          bottom: nil,
                          trailing: self.trailingAnchor,
                          padding: .init(top: 0, left: 60, bottom: 0, right: 0))
        cellTitle.centerYAnchor.constraint(equalTo: cellIconLeft.centerYAnchor).isActive = true
        cellSubtitle.anchor(top: cellTitle.bottomAnchor,
                             leading: cellTitle.leadingAnchor,
                             bottom: nil,
                             trailing: cellInnerIcon.leadingAnchor,
                             padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        cellIconRight.anchor(top: nil,
                          leading: nil,
                          bottom: nil,
                          trailing: self.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0)
                          )
        cellIconRight.centerYAnchor.constraint(equalTo: cellIconLeft.centerYAnchor).isActive = true
        cellRightTitle.anchor(top: nil,
                          leading: nil,
                          bottom: nil,
                          trailing: self.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 47))
        cellRightTitle.centerYAnchor.constraint(equalTo: cellIconLeft.centerYAnchor).isActive = true
        let innerTrailing: CGFloat = self.isPaymentCell ? 10 : 47
        cellInnerIcon.anchor(top: nil,
                          leading: nil,
                          bottom: nil,
                          trailing: self.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: innerTrailing)
                          )
        cellSeperator.anchor(top: nil,
                                 leading: self.leadingAnchor,
                                 bottom: self.bottomAnchor,
                                 trailing: self.trailingAnchor,
                                 padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
    }

    func setupAdditionalConfiguration() {

    }
}
