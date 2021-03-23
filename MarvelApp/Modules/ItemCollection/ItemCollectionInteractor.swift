//
//  ItemCollectionInteractor.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class ItemCollectionInteractor: BaseInteractor, ItemCollectionInteractorContract {
    weak var output: ItemCollectionInteractorOutputContract!

    var networkProvider: MarvelNetworkProvider
    
    init (provider: MarvelNetworkProvider) {
        self.networkProvider = provider
    }
    
    // MARK: - Public Methods
    func getCharacterList() -> Promise<[CellItemContract]> {
        return Promise<[CellItemContract]> { promise in
            firstly {
                self.networkProvider.getCharacters()
            }.done { characterList in
                var cellItemList = [CellItemContract]()
                for item in characterList {
                    cellItemList.append(item)
                }
                promise.fulfill(cellItemList)
            }.catch { error in
                #warning("TODO: Improve")
                promise.reject(error)
            }
        }
    }
}
