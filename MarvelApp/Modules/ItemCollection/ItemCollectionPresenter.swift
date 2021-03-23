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
        self.getCharacterList()
    }
    
    func getCharacterList() {
        firstly {
            self.interactor.getCharacterList()
        }.done { [weak self] characterList in
            self?.view.updateCharacterListData(with: characterList)
        }.catch { [weak self] error in
            
        }
    }
}

// MARK: - ItemCollectionInteractorOutputContract
extension ItemCollectionPresenter: ItemCollectionInteractorOutputContract {
    
}

// MARK: - ItemCollectionWireframeOutputContract
extension ItemCollectionPresenter: ItemCollectionWireframeOutputContract {
    
}
