//
//  ImageSelectorPresenter.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 27/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class ImageSelectorPresenter: BasePresenter, ImageSelectorPresenterContract {

    weak var view: ImageSelectorViewContract!
    var interactor: ImageSelectorInteractorContract!
    var entity: ImageSelectorEntityContract!
    var wireframe: ImageSelectorWireframeContract!

    // MARK: - Public Methods
    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
    
    func launchPhotoPickerView() {
        firstly {
            interactor.tryAccessToPhotoLibrary()
        }.done { [weak self] isEnabled in
            if isEnabled {
                self?.view.showPickerView()
            } else {
                self?.view.askForAccessToLibrary()
            }
        }.catch { error in
            #warning("TODO: error accediendo a las fotos")
        }
    }
}

// MARK: - ImageSelectorInteractorOutputContract
extension ImageSelectorPresenter: ImageSelectorInteractorOutputContract {
    
}

// MARK: - ImageSelectorWireframeOutputContract
extension ImageSelectorPresenter: ImageSelectorWireframeOutputContract {
    
}
