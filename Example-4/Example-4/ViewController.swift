//
//  ViewController.swift
//  Example-4
//
//  Created by Sergey Ryazanov on 06.03.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var validateLabel: UILabel!

    let validator = Validator()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    func setup() {
        loginTextField.placeholder = "Login"
        loginTextField.delegate = self
        self.validate(nil)

        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gestureAction(_:))))
    }

    // MARK: - Actions

    @objc func gestureAction(_ sender: UITapGestureRecognizer) {
        self.loginTextField.resignFirstResponder()
    }

    // MARK: - Validate

    func validate(_ login: String?) {
        let isValid = validator.validate(login)
        self.updateValidateLabel(isValid)
    }

    func updateValidateLabel(_ isValid: Bool) {
        validateLabel.textColor = isValid ? UIColor.green : UIColor.red
        validateLabel.text = isValid ? "Valid" : "Incorrect"
    }
}

extension ViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        let login = (text as NSString).replacingCharacters(in: range, with: string)
        self.validate(login)

        return true
    }
}

