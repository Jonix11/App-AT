//
//  RegisterFormPresenter.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 25/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class RegisterFormPresenter: BasePresenter, RegisterFormPresenterContract {

    weak var view: RegisterFormViewContract!
    var interactor: RegisterFormInteractorContract!
    var entity: RegisterFormEntityContract!
    var wireframe: RegisterFormWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
}

// MARK: - RegisterFormInteractorOutputContract
extension RegisterFormPresenter: RegisterFormInteractorOutputContract {
    
}

// MARK: - RegisterFormWireframeOutputContract
extension RegisterFormPresenter: RegisterFormWireframeOutputContract {
    
}
