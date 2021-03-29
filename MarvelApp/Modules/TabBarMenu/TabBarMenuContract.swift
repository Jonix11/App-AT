//
//  TabBarMenuContract.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 29/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol TabBarMenuEntityContract: BaseEntity {
    
}

protocol TabBarMenuViewContract: BaseTabBarController {
    var presenter: TabBarMenuPresenterContract! { get set }
    
}

protocol TabBarMenuPresenterContract: BasePresenter {
    var view: TabBarMenuViewContract! { get set }
    var interactor: TabBarMenuInteractorContract! { get set }
    var entity: TabBarMenuEntityContract! { get set }
    var wireframe: TabBarMenuWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
}

protocol TabBarMenuInteractorContract: BaseInteractor {
    var output: TabBarMenuInteractorOutputContract! {get set}
}

protocol TabBarMenuInteractorOutputContract: class {
    
}

protocol TabBarMenuWireframeContract: BaseWireframe {
    var output: TabBarMenuWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
}

protocol TabBarMenuWireframeOutputContract: class {

}
