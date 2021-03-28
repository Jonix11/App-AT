//
//  HttpbinNetworkProvider.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 26/3/21.
//

import Foundation
import Alamofire
import PromiseKit

protocol HttpbinProviderContract {
    func createUser(with data: [String: String]) -> Promise<Void>
}

class HttpbinNetworkProvider: HttpbinProviderContract {
    
    enum HttpBinMethods {
        case post
    }
    
    enum HttpbinNetworkError: Error {
        case errorSendingData
    }
    
    func createUser(with data: [String: String]) -> Promise<Void> {
        return Promise<Void> { promise in
            AF.request(self.getURL(method: .post),
                       method: .post,
                       parameters: data,
                       encoder: JSONParameterEncoder.default).response { response in
                        switch response.result {
                        case .failure:
                            promise.reject(HttpbinNetworkError.errorSendingData)
                        case .success:
                            promise.fulfill(())
                        }
            }
        }
    }
    
    private func getURL(method: HttpBinMethods) -> URL {
        switch method {
        case .post:
            var url = NetworkConstants.getHttpbinInitialURL()
            url.appendPathComponent("post/")
            return url
        }
    }
    
}
