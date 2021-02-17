//
//  Validator.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 18.02.2021.
//
import UIKit

enum ValidatorType
{
    case email
    case name
    case password
    case phone
    // add more cases ...
}

enum ValidationError: Error, LocalizedError
{
    case invalidUserName
    case invalidEmail
    case invalidPassword
    case invalidPhone

    var localizedDescription: String
    {
        switch self
        {
        case .invalidEmail:
            return "Geçersiz email"
        case .invalidUserName:
            return "Lütfen isminizi yazınız"
        case .invalidPassword:
            return "Parolanız 6 karakterden uzun olmalı"
        case .invalidPhone:
            return "Geçersiz telefon numarası"
        }
    }
}

extension String
{
    // MARK:- Properties

    var isValidEmail: Bool
    {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }

    // MARK:- Methods

    func validatedText(_ validationType: ValidatorType) throws
    {
        switch validationType
        {
        case .name:
            try validateUsername()
        case .email:
            try validateEmail()
        case .password:
            try validatePassword()
        case .phone:
            try validatePhone()
        }
    }

    // MARK:- Private Methods

    private func validateUsername() throws
    {
        if isEmpty
        {
            throw ValidationError.invalidUserName
        }
    }
    private func validateEmail() throws
    {
        if !isValidEmail
        {
            throw ValidationError.invalidEmail
        }
    }
    private func validatePassword() throws
    {
        if count < 6
        {
            throw ValidationError.invalidPassword
        }
    }
    private func validatePhone() throws
    {
        if count < 10
        {
            throw ValidationError.invalidPhone
        }
    }


}

extension UITextField
{
    func validatedText(_ validationType: ValidatorType) throws
    {
        do
        {
            try text?.validatedText(validationType)
        }
        catch let validationError
        {
            shake()
            throw validationError
        }
    }

    // MARK:- Private Methods

    func shake()
    {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 5
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x + 6, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x - 6, y: center.y))
        layer.add(animation, forKey: "position")
    }
}
