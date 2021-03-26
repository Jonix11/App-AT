//
//  RegisterFormContract.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 25/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol RegisterFormEntityContract: BaseEntity {
    
}

protocol RegisterFormViewContract: BaseViewController {
    var presenter: RegisterFormPresenterContract! { get set }
    
}

protocol RegisterFormPresenterContract: BasePresenter {
    var view: RegisterFormViewContract! { get set }
    var interactor: RegisterFormInteractorContract! { get set }
    var entity: RegisterFormEntityContract! { get set }
    var wireframe: RegisterFormWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
    func registerButtonPressed(with name: String?, lastname: String?, email: String?, password: String?, repeatPassword: String?)
}

protocol RegisterFormInteractorContract: BaseInteractor {
    var output: RegisterFormInteractorOutputContract! {get set}
}

protocol RegisterFormInteractorOutputContract: class {
    
}

protocol RegisterFormWireframeContract: BaseWireframe {
    var output: RegisterFormWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
}

protocol RegisterFormWireframeOutputContract: class {

}
