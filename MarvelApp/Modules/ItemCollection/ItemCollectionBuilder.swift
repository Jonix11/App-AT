//
//  ItemCollectionBuilder.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class ItemCollectionBuilder {

    static func build() -> ItemCollectionView {
        let view = ItemCollectionView.init(nibName: String(describing: ItemCollectionView.self), bundle: nil)
        let presenter = ItemCollectionPresenter()
        let entity = ItemCollectionEntity()
        let wireframe = ItemCollectionWireframe()
        
        let provider = MarvelNetworkProvider()
        let interactor = ItemCollectionInteractor(provider: provider)
        
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
