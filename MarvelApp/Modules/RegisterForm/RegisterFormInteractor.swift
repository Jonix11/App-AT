//
//  RegisterFormInteractor.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 25/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

class RegisterFormInteractor: BaseInteractor, RegisterFormInteractorContract {
    weak var output: RegisterFormInteractorOutputContract!

    var networkProvider: MarvelNetworkProvider
    
    init (provider: MarvelNetworkProvider) {
        self.networkProvider = provider
    }
}
