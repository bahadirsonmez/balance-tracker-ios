//
//  CardView.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 13.03.2021.
//
import UIKit
extension Constants {
    static let cardHeight: CGFloat = 260
}

class CardView: UIView {

    let colors = Constants.Colors.self
    let fonts = Constants.Fonts.self
    var text: String!
    var name: String = ""

    let backView = UIView()
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?

    lazy var cardView: UIView = {
        let view = UIView()
        view.cornerRadius = 6
        view.contentMode = .top
        view.backgroundColor = .white
        return view
    }()

    private var view: UIView!

    init(with view: UIView) {
        self.view = view
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardView: SetupCodeView {
    func buildViewHierarchy() {
        cardView.addSubview(view)
    }
    func setupConstraints() {
        view.fillSuperview()
    }
    func setupAdditionalConfiguration() {
    }
}

//MARK: - Card Functions
extension CardView: UITextFieldDelegate {
    func showCard() {
        //show menu
        if let window = UIApplication.shared.windows.first {
            backView.backgroundColor = .white
            backView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(handleDismiss)))
            window.addSubview(backView)
            window.addSubview(cardView)
            let height: CGFloat = Constants.cardHeight
            let y = window.frame.height - height
            cardView.frame = CGRect(x: 0, y: window.frame.height,
                                    width: window.frame.width, height: height)
            backView.frame = window.frame
            backView.alpha = 0
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
            cardView.addGestureRecognizer(panGesture)
            UIView.animate(withDuration: 0.7, delay: 0,
                           usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
                           options: .curveEaseInOut, animations: {
                            self.backView.alpha = 0.05
                            self.cardView.frame = CGRect(x:0, y: y,
                                                         width: self.cardView.frame.width,
                                                         height: self.cardView.frame.height)
                           }, completion: {_ in
                            if !self.hasSetPointOrigin {
                                self.hasSetPointOrigin = true
                                self.pointOrigin = self.cardView.frame.origin                }
                           })
        }
    }
    @objc func handleDismiss() {
        hideCard()
    }

    func hideCard() {
        UIView.animate(withDuration: 0.5, animations: {
            self.backView.alpha = 0
            if let window = UIApplication.shared.windows.first {
                self.cardView.frame = CGRect(x: 0, y: window.frame.height,
                                             width: self.cardView.frame.width,
                                             height: self.cardView.frame.height)
            }
        }, completion: { _ in
            self.cardView.removeFromSuperview()
            self.backView.removeFromSuperview()
        }
        )
    }

    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: cardView)
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        cardView.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: cardView)
            if dragVelocity.y >= 600 {
                handleDismiss()
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.cardView.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: Constants.cardHeight)
                }
            }
        }
    }

    //MARK: - TextFieldDelegateSetup
    func dragLayoutWhenTappedTextField() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil);
    }

    @objc func keyboardWillShow(sender: NSNotification) {
        var keyboardHeight: CGFloat = 0
        if let window = UIApplication.shared.windows.first {
            if let keyboardRect = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                keyboardHeight = keyboardRect.height
            }
            let height: CGFloat = Constants.cardHeight
            let y = window.frame.height - height - keyboardHeight
            UIView.animate(
                withDuration: 0.7, delay: 0,
                usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
                options: .curveEaseInOut, animations: {
                    self.backView.alpha = 0.05
                    self.cardView.frame = CGRect(x:0, y: y,
                                                 width: self.cardView.frame.width,
                                                 height: self.cardView.frame.height)
                }, completion: {_ in
                    if !self.hasSetPointOrigin {
                        self.hasSetPointOrigin = true
                        self.pointOrigin = self.cardView.frame.origin

                    }
                }
            )
        }
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        print("keyboardWillHide")
        if let window = UIApplication.shared.windows.first {
            let height: CGFloat = Constants.cardHeight
            let y = window.frame.height - height
            UIView.animate(
                withDuration: 0.7, delay: 0,
                usingSpringWithDamping: 0.8, initialSpringVelocity: 1,
                options: .curveEaseInOut, animations: {
                    self.backView.alpha = 0.05
                    self.cardView.frame = CGRect(x:0, y: y,
                                                 width: self.cardView.frame.width,
                                                 height: self.cardView.frame.height)
                }, completion: {_ in
                    if !self.hasSetPointOrigin {
                        self.hasSetPointOrigin = true
                        self.pointOrigin = self.cardView.frame.origin
                    }
                }
            )
        }
    }
}
