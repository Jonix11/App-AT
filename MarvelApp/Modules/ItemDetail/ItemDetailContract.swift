//
//  ItemDetailContract.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol ItemDetailEntityContract: BaseEntity {
    
}

protocol ItemDetailViewContract: BaseViewController {
    var presenter: ItemDetailPresenterContract! { get set }
    
}

protocol ItemDetailPresenterContract: BasePresenter {
    var view: ItemDetailViewContract! { get set }
    var interactor: ItemDetailInteractorContract! { get set }
    var entity: ItemDetailEntityContract! { get set }
    var wireframe: ItemDetailWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
}

protocol ItemDetailInteractorContract: BaseInteractor {
    var output: ItemDetailInteractorOutputContract! {get set}
}

protocol ItemDetailInteractorOutputContract: class {
    
}

protocol ItemDetailWireframeContract: BaseWireframe {
    var output: ItemDetailWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
}

protocol ItemDetailWireframeOutputContract: class {

}
