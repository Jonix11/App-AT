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
    func getCharacters(withOffset offset: String) -> Promise<[Character]>
}

class MarvelNetworkProvider: MarvelProviderContract {
    
    enum MarvelURLEndpoint {
        case characters
    }
    
    /// Marver Network errors
    enum MarvelNetworkError: Error, LocalizedError {
        case getInitialDataError
        
        /// Localized description
        var localizedDescription: String {
            switch self {
            case .getInitialDataError:
                return "Error. Can't get data"
            }
        }
    }
    
    func getCharacters(withOffset offset: String) -> Promise<[Character]> {
        return Promise<[Character]> { promise in
            self.getInitialData(fromEndpoint: .characters, offset: offset).done { data in
                let characterList = self.getCharacterList(fromData: data)
                promise.fulfill(characterList)
            }.catch { _ in
                promise.reject(MarvelNetworkError.getInitialDataError)
            }
        }
    }
    
    private func getURL(endpoint: MarvelURLEndpoint, offset: String) -> URL {
        switch endpoint {
        case .characters:
            var url = NetworkConstants.getMarvelInitialURL(withOffset: offset)
            url.appendPathComponent("characters")
            return url
        }
    }
    
    private func getInitialData(fromEndpoint endpoint: MarvelURLEndpoint, offset: String) -> Promise<[[String: Any]]> {
        return Promise<[[String: Any]]> { promise in
            AF.request(getURL(endpoint: endpoint, offset: offset)).responseJSON { response in
                guard let data = try? response.result.get() as? [String: Any],
                      let dataResultData = data["data"] as? [String: Any],
                      let result = dataResultData["results"] as? [[String: Any]] else {
                    promise.reject(MarvelNetworkError.getInitialDataError)
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
