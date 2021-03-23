//
//  ItemCollectionInteractor.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class ItemCollectionInteractor: BaseInteractor, ItemCollectionInteractorContract {
    weak var output: ItemCollectionInteractorOutputContract!

    var networkProvider: MarvelNetworkProvider
    
    init (provider: MarvelNetworkProvider) {
        self.networkProvider = provider
    }
}
