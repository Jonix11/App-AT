//
//  ItemDetailPresenter.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class ItemDetailPresenter: BasePresenter, ItemDetailPresenterContract {

    weak var view: ItemDetailViewContract!
    var interactor: ItemDetailInteractorContract!
    var entity: ItemDetailEntityContract!
    var wireframe: ItemDetailWireframeContract!

    // MARK: - Public Methods
    func viewDidLoad() {

    }

    func viewWillAppear() {
        self.getCharacterDetail()
    }
    
    func getCharacterDetail() {
        let character = self.interactor.retrieveCharacterDetail()
        self.view.loadDataInView(with: character)
    }
}

// MARK: - ItemDetailInteractorOutputContract
extension ItemDetailPresenter: ItemDetailInteractorOutputContract {
    
}

// MARK: - ItemDetailWireframeOutputContract
extension ItemDetailPresenter: ItemDetailWireframeOutputContract {
    
}
