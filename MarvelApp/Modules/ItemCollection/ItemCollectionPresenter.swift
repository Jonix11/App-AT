//
//  ItemCollectionPresenter.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class ItemCollectionPresenter: BasePresenter, ItemCollectionPresenterContract {

    weak var view: ItemCollectionViewContract!
    var interactor: ItemCollectionInteractorContract!
    var entity: ItemCollectionEntityContract!
    var wireframe: ItemCollectionWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
}


// MARK: - ItemCollectionInteractorOutputContract
extension ItemCollectionPresenter: ItemCollectionInteractorOutputContract {
    
}

// MARK: - ItemCollectionWireframeOutputContract
extension ItemCollectionPresenter: ItemCollectionWireframeOutputContract {
    
}
