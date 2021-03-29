//
//  ItemCollectionPresenter.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class ItemCollectionPresenter: BasePresenter, ItemCollectionPresenterContract {

    weak var view: ItemCollectionViewContract!
    var interactor: ItemCollectionInteractorContract!
    var entity: ItemCollectionEntityContract!
    var wireframe: ItemCollectionWireframeContract!

    // MARK: - Public Methods
    func viewDidLoad() {

    }

    func viewWillAppear() {
        
    }
    
    func getItemList(withEndpoint endpoint: MarvelURLEndpoint) {
        firstly {
            self.interactor.getItemList(withEndpoint: endpoint)
        }.done { [weak self] itemList in
            if itemList.isEmpty {
                self?.view.setEmptyView()
            } else {
                self?.view.updateItemListData(with: itemList)
            }
        }.catch { [weak self] error in
            self?.view.setErrorView(with: error.localizedDescription)
        }
    }
    
    func itemSelected(at index: Int) {
        let itemDetail = self.interactor.returnItem(at: index)
        self.wireframe.showDetailView(with: itemDetail)
    }
    
    func resetItemList() {
        self.interactor.resetItemList()
    }
}

// MARK: - ItemCollectionInteractorOutputContract
extension ItemCollectionPresenter: ItemCollectionInteractorOutputContract {
    
}

// MARK: - ItemCollectionWireframeOutputContract
extension ItemCollectionPresenter: ItemCollectionWireframeOutputContract {
    
}
