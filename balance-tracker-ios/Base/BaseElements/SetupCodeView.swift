//
//  SetupCodeView.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 18.02.2021.
//
import Foundation

protocol SetupCodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension SetupCodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
