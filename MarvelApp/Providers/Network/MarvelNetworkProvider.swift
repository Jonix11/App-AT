//
//  MarvelNetworkProvider.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 20/3/21.
//

import Foundation
import Alamofire
import PromiseKit

protocol MarvelProviderContract {
    func getCharacters() -> Promise<[Character]>
}

class MarvelNetworkProvider: MarvelProviderContract {
    
    enum MarvelURLEndpoint {
        case characters
    }
    
    func getCharacters() -> Promise<[Character]> {
        return Promise<[Character]> { promise in
            AF.request(getURL(endpoint: .characters)).responseJSON { response in
                
            }
        }
    }
    
    private func getURL(endpoint: MarvelURLEndpoint) -> URL {
        switch endpoint {
        case .characters:
            var url = NetworkConstants.getInitialURL()
            url.appendPathComponent("characters/")
            return url
        }
    }
}
