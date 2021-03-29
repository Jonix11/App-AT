//
//  TabBarMenuPresenter.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 29/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class TabBarMenuPresenter: BasePresenter, TabBarMenuPresenterContract {

    weak var view: TabBarMenuViewContract!
    var interactor: TabBarMenuInteractorContract!
    var entity: TabBarMenuEntityContract!
    var wireframe: TabBarMenuWireframeContract!

    func viewDidLoad() {

    }

    func viewWillAppear() {

    }
}


// MARK: - TabBarMenuInteractorOutputContract
extension TabBarMenuPresenter: TabBarMenuInteractorOutputContract {
    
}

// MARK: - TabBarMenuWireframeOutputContract
extension TabBarMenuPresenter: TabBarMenuWireframeOutputContract {
    
}
