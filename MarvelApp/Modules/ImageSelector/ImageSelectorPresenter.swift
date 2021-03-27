//
//  ImageSelectorPresenter.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 27/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class ImageSelectorPresenter: BasePresenter, ImageSelectorPresenterContract {

    weak var view: ImageSelectorViewContract!
    var interactor: ImageSelectorInteractorContract!
    var entity: ImageSelectorEntityContract!
    var wireframe: ImageSelectorWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
}


// MARK: - ImageSelectorInteractorOutputContract
extension ImageSelectorPresenter: ImageSelectorInteractorOutputContract {
    
}

// MARK: - ImageSelectorWireframeOutputContract
extension ImageSelectorPresenter: ImageSelectorWireframeOutputContract {
    
}
