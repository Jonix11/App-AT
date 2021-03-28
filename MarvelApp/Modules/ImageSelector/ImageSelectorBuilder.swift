//
//  ImageSelectorBuilder.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 27/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class ImageSelectorBuilder {

    static func build() -> ImageSelectorView {
        let view = ImageSelectorView.init(nibName: String(describing: ImageSelectorView.self), bundle: nil)
        let presenter = ImageSelectorPresenter()
        let entity = ImageSelectorEntity()
        let wireframe = ImageSelectorWireframe()
        
        let provider = PhotoLibraryProvider()
        let interactor = ImageSelectorInteractor(provider: provider)
        
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
