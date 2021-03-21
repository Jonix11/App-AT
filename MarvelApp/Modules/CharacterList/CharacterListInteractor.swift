//
//  CharacterListInteractor.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class CharacterListInteractor: BaseInteractor, CharacterListInteractorContract {
    
    weak var output: CharacterListInteractorOutputContract!

    var networkProvider: MarvelNetworkProvider
    
    init (provider: MarvelNetworkProvider) {
        self.networkProvider = provider
    }
    
    func getCharacterList() -> Promise<[CellItemContract]> {
        return Promise<[CellItemContract]> { promise in
            firstly {
                networkProvider.getCharacters()
            }.done { characterList in
                var cellCharactersList = [CellItemContract]()
                for character in characterList {
                    cellCharactersList.append(character)
                }
                promise.fulfill(cellCharactersList)
            }.catch { error in
                #warning("TODO: Improve")
                promise.reject(error)
            }
        }
    }
}
