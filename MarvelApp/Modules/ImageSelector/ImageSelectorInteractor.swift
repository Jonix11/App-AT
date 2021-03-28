//
//  ImageSelectorInteractor.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 27/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class ImageSelectorInteractor: BaseInteractor, ImageSelectorInteractorContract {
    weak var output: ImageSelectorInteractorOutputContract!

    var photoProvider: PhotoLibraryProviderContract
    
    init (provider: PhotoLibraryProviderContract) {
        self.photoProvider = provider
    }
    
    func tryAccessToPhotoLibrary() -> Promise<Bool> {
        return Promise<Bool> { promise in
            firstly {
                photoProvider.accessToLibraryEnable()
            }.done { isEnabled in
                if isEnabled {
                    promise.fulfill(isEnabled)
                } else {
                    self.photoProvider.requestAuthorization().done { requested in
                        promise.fulfill(requested)
                    }.catch { error in
                        #warning("TODO: Error pidiendo autorización")
                        promise.reject(error)
                    }
                }
            }.catch { error in
                promise.reject(error)
            }
        }
        
    }
}
