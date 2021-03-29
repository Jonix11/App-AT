//
//  TabBarMenuBuilder.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 29/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class TabBarMenuBuilder {

    static func build() -> TabBarMenuView {
        let view = TabBarMenuView.init(nibName: String(describing: TabBarMenuView.self), bundle: nil)
        
        return view
    }
    
    static func setupPresenter(view: TabBarMenuViewContract) {
        let presenter = TabBarMenuPresenter()
        let entity = TabBarMenuEntity()
        let wireframe = TabBarMenuWireframe()
        
        let interactor = TabBarMenuInteractor()
        
        view.presenter = presenter
        view.presenter.view = view
        view.presenter.entity = entity
        view.presenter.interactor = interactor
        view.presenter.interactor.output = presenter
        view.presenter.wireframe = wireframe
        
        view.presenter.wireframe.output = presenter
        view.presenter.wireframe.view = view
    }
}
