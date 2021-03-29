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
    var itemList = [ItemDetailContract]()
    
    init (provider: MarvelNetworkProvider) {
        self.networkProvider = provider
    }
    
    // MARK: - Public Methods
    func getItemList(withEndpoint endpoint: MarvelURLEndpoint) -> Promise<[CellItemContract]> {
        return Promise<[CellItemContract]> { promise in
            firstly {
                self.networkProvider.getItems(withOffset: String(self.itemList.count),
                                              endpoint: endpoint)
            }.done { itemList in
                itemList.forEach {
                    self.itemList.append($0)
                }
                promise.fulfill(self.itemList)
            }.catch { error in
                promise.reject(error)
            }
        }
    }
    
    func returnItem(at index: Int) -> ItemDetailContract {
        return self.itemList[index]
    }
    
    func resetItemList() {
        itemList = []
    }
}
