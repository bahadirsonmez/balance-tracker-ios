//
//  BalanceHeader.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 27.02.2021.
//

import UIKit

class BalanceHeader: BaseHeader {
    var buttonTapped : (() -> Void)? = nil

    private lazy var title: UILabel = {
        let label = UILabel()
        label.apply(style: .init(font: font.bold24))
        label.text = "İsim"
        return label
    }()

    private lazy var actionTitle: UILabel = {
        let label = UILabel()
        label.apply(style: .init(font: font.bold18, textAlignment: .right))
        label.text = "Adet"
        return label
    }()

    private lazy var seperator: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.gray30
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(){
        addSubviews(title, actionTitle, seperator)
        title.anchor(
            leading: leadingAnchor,
            padding: .init(top: 0, left: 35, bottom: 0, right: 0)
        )
        title.centerY(to: self)
        actionTitle.anchor(
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 20)
        )
        actionTitle.centerY(to: self)
        seperator.anchor(
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            size: .init(width: 0, height: 2)
        )
    }

    func loadHeader(_ title: String, actionTitle: String) {
        self.title.text = title
        self.actionTitle.text = actionTitle
    }
}
