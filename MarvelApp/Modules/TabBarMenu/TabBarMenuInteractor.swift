//
//  TabBarMenuInteractor.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 29/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class TabBarMenuInteractor: BaseInteractor, TabBarMenuInteractorContract {
    weak var output: TabBarMenuInteractorOutputContract!

    var networkProvider: MyProviderContract
    
    init (provider: MyProviderContract) {
        self.networkProvider = provider
    }
}
