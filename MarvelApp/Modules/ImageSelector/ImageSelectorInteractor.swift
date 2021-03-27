//
//  ImageSelectorInteractor.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 27/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class ImageSelectorInteractor: BaseInteractor, ImageSelectorInteractorContract {
    weak var output: ImageSelectorInteractorOutputContract!

    var networkProvider: MarvelProviderContract
    
    init (provider: MarvelProviderContract) {
        self.networkProvider = provider
    }
}
