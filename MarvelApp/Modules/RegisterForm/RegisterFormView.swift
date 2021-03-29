//
//  RegisterFormView.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 25/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class RegisterFormView: BaseViewController, RegisterFormViewContract {
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    // MARK: - Actions
    @IBAction func registerButtonClicked(_ sender: Any) {
        self.sendData()
    }
    
    // MARK: - Properties
    // swiftlint:disable:next weak_delegate
    private var textFieldDelegate = FormTextFieldDelegate()
    
	var presenter: RegisterFormPresenterContract!

	// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
    // En caso de que haga tap en la view, ocultar el teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setupView() {
        let textFields = [nameTextField, lastnameTextField, emailTextField, passwordTextField, repeatPasswordTextField]
        for (index, textField) in textFields.enumerated() {
            textField?.tag = index
            textField?.delegate = textFieldDelegate
        }
        textFieldDelegate.presenter = self.presenter
    }
    
    // MARK: - Public Methods
    func resetTextFieldsContent() {
        let textFields = [nameTextField, lastnameTextField, emailTextField, passwordTextField, repeatPasswordTextField]
        textFields.forEach { $0?.text = "" }
    }
    
    func showErrorAlert(with error: String) {
        let retry = UIAlertAction(title: "Retry", style: .default) { _ in
            self.sendData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.resetTextFieldsContent()
        }
        self.presenter.wireframe.showCustomModalAlert(self,
                                                      title: "Error",
                                                      content: error,
                                                      customActions: [retry, cancel],
                                                      completion: nil)
    }
    
    // MARK: - Private Methods
    func sendData() {
        presenter.registerButtonPressed(with: nameTextField.text,
                                        lastname: lastnameTextField.text,
                                        email: emailTextField.text,
                                        password: passwordTextField.text,
                                        repeatPassword: repeatPasswordTextField.text)
    }
}

class FormTextFieldDelegate: NSObject, UITextFieldDelegate {
    weak var presenter: RegisterFormPresenterContract!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextTextField = textField.superview?.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if text.isEmpty {
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.red.cgColor
            } else {
                textField.layer.borderWidth = 0
            }
        }
    }
}
