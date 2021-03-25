//
//  RegisterFormBuilder.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 25/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class RegisterFormBuilder {

    static func build() -> RegisterFormView {
        let view = RegisterFormView.init(nibName: String(describing: RegisterFormView.self), bundle: nil)
        let presenter = RegisterFormPresenter()
        let entity = RegisterFormEntity()
        let wireframe = RegisterFormWireframe()
        
        let provider = MarvelNetworkProvider()
        let interactor = RegisterFormInteractor(provider: provider)
        
        view.presenter = presenter
        view.presenter.view = view
        view.presenter.entity = entity
        view.presenter.interactor = interactor
        view.presenter.interactor.output = presenter
        view.presenter.wireframe = wireframe
        
        view.presenter.wireframe.output = presenter
        view.presenter.wireframe.view = view
        
        return view
    }
}
