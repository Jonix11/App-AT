//
//  ItemCollectionContract.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol ItemCollectionEntityContract: BaseEntity {
    
}

protocol ItemCollectionViewContract: BaseViewController {
    var presenter: ItemCollectionPresenterContract! { get set }
    
    func updateCharacterListData(with character: [CellItemContract])
    
}

protocol ItemCollectionPresenterContract: BasePresenter {
    var view: ItemCollectionViewContract! { get set }
    var interactor: ItemCollectionInteractorContract! { get set }
    var entity: ItemCollectionEntityContract! { get set }
    var wireframe: ItemCollectionWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
    func getCharacterList()
    func characterSelected(at index: Int)
}

protocol ItemCollectionInteractorContract: BaseInteractor {
    var output: ItemCollectionInteractorOutputContract! {get set}
    
    func getCharacterList() -> Promise<[CellItemContract]>
    func returnCharacter(at index: Int) -> ItemDetailContract
}

protocol ItemCollectionInteractorOutputContract: class {
    
}

protocol ItemCollectionWireframeContract: BaseWireframe {
    var output: ItemCollectionWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
    
    func showDetailView(with character: ItemDetailContract)
}

protocol ItemCollectionWireframeOutputContract: class {

}
