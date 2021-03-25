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

    private func setupView() {
        let textFields = [nameTextField, lastnameTextField, emailTextField, passwordTextField, repeatPasswordTextField]
        for (index, textField) in textFields.enumerated() {
            textField?.tag = index
            textField?.delegate = textFieldDelegate
        }
        
    }
}

class FormTextFieldDelegate: NSObject, UITextFieldDelegate {
    
}
