//
//  CharacterListPresenter.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class CharacterListPresenter: BasePresenter, CharacterListPresenterContract {

    weak var view: CharacterListViewContract!
    var interactor: CharacterListInteractorContract!
    var entity: CharacterListEntityContract!
    var wireframe: CharacterListWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
}


// MARK: - CharacterListInteractorOutputContract
extension CharacterListPresenter: CharacterListInteractorOutputContract {
    
}

// MARK: - CharacterListWireframeOutputContract
extension CharacterListPresenter: CharacterListWireframeOutputContract {
    
}
