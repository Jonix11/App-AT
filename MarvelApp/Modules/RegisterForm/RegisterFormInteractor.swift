//
//  RegisterFormInteractor.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 25/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import PromiseKit

class RegisterFormInteractor: BaseInteractor, RegisterFormInteractorContract {
    
    weak var output: RegisterFormInteractorOutputContract!

    var networkProvider: HttpbinProviderContract
    
    init (provider: HttpbinProviderContract) {
        self.networkProvider = provider
    }
    
    // MARK: - Public Methods
    func createUser(with data: [String : String]) -> Promise<Void> {
        return Promise<Void> { promise in
            firstly {
                networkProvider.createUser(with: data)
            }.done {
                promise.fulfill(())
            }.catch { error in
                #warning("TODO: Improve")
                promise.reject(error)
            }
        }
    }
}
