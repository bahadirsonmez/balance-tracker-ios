//
//  UIView+layout.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 18.02.2021.
//
import UIKit

extension UIView {

    func addSubviews(_ views: UIView...){
        views.forEach({
            self.addSubview($0)
        })
    }

    func fillSuperview() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }

    func fillSuperViewSafeArea(_ safeArea: UILayoutGuide) {
        anchor(top: safeArea.topAnchor, leading: safeArea.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: safeArea.trailingAnchor)
    }

    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }

    func centerView(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func centerX(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func centerY(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func anchorBottomCenterX(to view: UIView, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding).isActive = true
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func anchorTopCenterX(to view: UIView, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    func anchorLeftCenterY(to view: UIView, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false

        leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func placeTopStrech(to view: UIView, height: CGFloat, width: CGFloat = 0, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide

        leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0).isActive = true
        trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0).isActive = true
        topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding).isActive = true
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    func placeCenter(to view: UIView, height: CGFloat, width: CGFloat = 0, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func placeLeftTo(to view: UIView, height: CGFloat = 0, width: CGFloat = 0, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding).isActive = true
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func placeLeftCenter(to view: UIView, height: CGFloat = 0, width: CGFloat = 0, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func placeBottom(to view: UIView, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func placeTopLeft(to view: UIView, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left).isActive = true
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
