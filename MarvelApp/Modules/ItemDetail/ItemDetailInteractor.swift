//
//  ItemDetailInteractor.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class ItemDetailInteractor: BaseInteractor, ItemDetailInteractorContract {
    weak var output: ItemDetailInteractorOutputContract!

    var networkProvider: MarvelNetworkProvider
    var character: ItemDetailContract
    
    init (provider: MarvelNetworkProvider, character: ItemDetailContract) {
        self.networkProvider = provider
        self.character = character
    }
    
    // MARK: - Public Methods
    func retrieveCharacterDetail() -> ItemDetailContract {
        return character
    }
}
