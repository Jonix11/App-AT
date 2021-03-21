//
//  CharacterListContract.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol CharacterListEntityContract: BaseEntity {
    
}

protocol CharacterListViewContract: BaseViewController {
    var presenter: CharacterListPresenterContract! { get set }
    
}

protocol CharacterListPresenterContract: BasePresenter {
    var view: CharacterListViewContract! { get set }
    var interactor: CharacterListInteractorContract! { get set }
    var entity: CharacterListEntityContract! { get set }
    var wireframe: CharacterListWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
}

protocol CharacterListInteractorContract: BaseInteractor {
    var output: CharacterListInteractorOutputContract! {get set}
}

protocol CharacterListInteractorOutputContract: class {
    
}

protocol CharacterListWireframeContract: BaseWireframe {
    var output: CharacterListWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
}

protocol CharacterListWireframeOutputContract: class {

}
