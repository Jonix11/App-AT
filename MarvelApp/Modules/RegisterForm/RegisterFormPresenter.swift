//
//  RegisterFormPresenter.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 25/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class RegisterFormPresenter: BasePresenter, RegisterFormPresenterContract {

    weak var view: RegisterFormViewContract!
    var interactor: RegisterFormInteractorContract!
    var entity: RegisterFormEntityContract!
    var wireframe: RegisterFormWireframeContract!

    // MARK: - Public Methods
    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
    
    func registerButtonPressed(with name: String?,
                               lastname: String?,
                               email: String?,
                               password: String?,
                               repeatPassword: String?) {
        
        if let name = name, let lastname = lastname, let email = email, let password = password, let password2 = repeatPassword {
            if name.isEmpty || lastname.isEmpty || email.isEmpty || password.isEmpty || password2.isEmpty {
                wireframe.showCustomModalAlert(view,
                                               title: "Warning",
                                               content: "Enter data in all fields.",
                                               completion: nil)
            } else {
                if !email.isValidEmail() {
                    wireframe.showCustomModalAlert(view,
                                                   title: "Warning",
                                                   content: "The introduced email isn't a valid email.",
                                                   completion: nil)
                } else {
                    if password != password2 {
                        wireframe.showCustomModalAlert(view,
                                                       title: "Warning",
                                                       content: "The passwords do not match.",
                                                       completion: nil)
                    } else {
                        let fullname = "\(name) \(lastname)"
                        let data = [
                            "fullname": fullname,
                            "email": email,
                            "password": password
                        ]
                        firstly {
                            self.interactor.createUser(with: data)
                        }.done { [weak self] in
                            self?.wireframe.showCustomModalAlert(self?.view,
                                                                 title: "User Created",
                                                                 content: "User created correctly.",
                                                                 completion: self?.view.resetTextFieldsContent)
                        }.catch { error in
                            self.view.showErrorAlert(with: error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - RegisterFormInteractorOutputContract
extension RegisterFormPresenter: RegisterFormInteractorOutputContract {
    
}

// MARK: - RegisterFormWireframeOutputContract
extension RegisterFormPresenter: RegisterFormWireframeOutputContract {
    
}
