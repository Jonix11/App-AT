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
    var characterList = [Character]()
    var characterList4Cell = [CellItemContract]()
    
    init (provider: MarvelNetworkProvider) {
        self.networkProvider = provider
    }
    
    // MARK: - Public Methods
    func getCharacterList() -> Promise<[CellItemContract]> {
        return Promise<[CellItemContract]> { promise in
            firstly {
                self.networkProvider.getCharacters(withOffset: String(self.characterList.count))
            }.done { characterList in
                characterList.forEach {
                    self.characterList.append($0)
                }
                for item in characterList {
                    self.characterList4Cell.append(item)
                }
                promise.fulfill(self.characterList4Cell)
            }.catch { error in
                #warning("TODO: Improve")
                promise.reject(error)
            }
        }
    }
    
    func returnCharacter(at index: Int) -> ItemDetailContract {
        return self.characterList[index]
    }
}
