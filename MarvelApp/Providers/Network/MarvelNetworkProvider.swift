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
            self.getInitialData(fromEndpoint: .characters).done { data in
                let characterList = self.getCharacterList(fromData: data)
                promise.fulfill(characterList)
            }.catch { error in
                #warning("TODO: improve")
                promise.reject(error)
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
    
    private func getInitialData(fromEndpoint endpoint: MarvelURLEndpoint) -> Promise<[[String: Any]]> {
        return Promise<[[String: Any]]> { promise in
            AF.request(getURL(endpoint: endpoint)).responseJSON { response in
                guard let data = try? response.result.get() as? [String: Any],
                      let dataResultData = data["data"] as? [String: Any],
                      let result = dataResultData["results"] as? [[String: Any]] else {
                    return
                }
                promise.fulfill(result)
            }
        }
    }
    
    private func getCharacterList(fromData data: [[String: Any]]) -> [Character] {
        var characterList = [Character]()
        for item in data {
            if let character = try? Character(JSON: item) {
                characterList.append(character)
            }
        }
        return characterList
    }
}
