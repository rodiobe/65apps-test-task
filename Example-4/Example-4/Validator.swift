//
//  Validator.swift
//  Example-4
//
//  Created by Sergey Ryazanov on 06.03.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

class Validator {

    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }

    func validateNick(candidate: String) -> Bool {
        let nickRegex = "[^\\d.-]{1}[a-zA-Z0-9-.]{2,31}"
        return NSPredicate(format: "SELF MATCHES %@", nickRegex).evaluate(with: candidate)
    }

    func validate(_ login: String?) -> Bool {
        guard let login = login?.trimmingCharacters(in: CharacterSet.whitespaces), login.isEmpty == false else {
            return false
        }

        if login.contains("@") {
            return validateEmail(candidate: login)
        } else {
            return validateNick(candidate: login)
        }
    }
}
