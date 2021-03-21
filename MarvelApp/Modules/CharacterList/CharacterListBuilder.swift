//
//  CharacterListBuilder.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class CharacterListBuilder {

    static func build() -> CharacterListView {
        let view = CharacterListView.init(nibName: String(describing: CharacterListView.self), bundle: nil)
        let presenter = CharacterListPresenter()
        let entity = CharacterListEntity()
        let wireframe = CharacterListWireframe()
        
        let provider = MarvelNetworkProvider()
        let interactor = CharacterListInteractor(provider: provider)
        
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
