//
//  ItemDetailBuilder.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class ItemDetailBuilder {

    static func build() -> ItemDetailView {
        let view = ItemDetailView.init(nibName: String(describing: ItemDetailView.self), bundle: nil)
        let presenter = ItemDetailPresenter()
        let entity = ItemDetailEntity()
        let wireframe = ItemDetailWireframe()
        
        let provider = MarvelNetworkProvider()
        let interactor = ItemDetailInteractor(provider: provider)
        
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
