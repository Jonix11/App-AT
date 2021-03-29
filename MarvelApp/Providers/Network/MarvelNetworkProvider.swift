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
    func getItems(withOffset offset: String, endpoint: MarvelURLEndpoint) -> Promise<[ItemDetailContract]>
}

enum MarvelURLEndpoint {
    case characters
    case events
}

class MarvelNetworkProvider: MarvelProviderContract {
    
    enum MarvelNetworkError: Error {
        case getInitialDataError
    }
    
    func getItems(withOffset offset: String, endpoint: MarvelURLEndpoint) -> Promise<[ItemDetailContract]> {
        return Promise<[ItemDetailContract]> { promise in
            self.getInitialData(fromEndpoint: endpoint, offset: offset).done { data in
                let itemList = self.getItemList(fromData: data, endpoint: endpoint)
                promise.fulfill(itemList)
            }.catch { error in
                promise.reject(MarvelNetworkError.getInitialDataError)
            }
        }
    }
    
    private func getURL(endpoint: MarvelURLEndpoint, offset: String) -> URL {
        var url = NetworkConstants.getMarvelInitialURL(withOffset: offset)
        switch endpoint {
        case .characters:
            url.appendPathComponent("characters")
        case .events:
            url.appendPathComponent("events")
        }
        return url
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
    
    private func getItemList(fromData data: [[String: Any]], endpoint: MarvelURLEndpoint) -> [ItemDetailContract] {
        var itemList = [ItemDetailContract]()
        for item in data {
            switch endpoint {
            case .characters:
                if let character = try? Character(JSON: item) {
                    itemList.append(character)
                }
            case .events:
                if let event = try? Event(JSON: item) {
                    itemList.append(event)
                }
            }
        }
        return itemList
    }
}
