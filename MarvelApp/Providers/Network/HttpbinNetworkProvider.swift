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
    
//    func createUser(with data: [String : String]) -> Promise<Void> {
//        return Promise<Void> { promise in
//            AF.request(self.getURL(method: .post),
//                       method: .post,
//                       parameters: data,
//                       encoder: JSONParameterEncoder.default).response { response in
//                        switch response.result {
//                        case .failure(let error):
//                            print(error)
//                            promise.reject(error)
//                        case .success(let data):
//                            print(data)
//                            promise.fulfill(())
//                        }
//            }
//        }
//    }
    
    func createUser(with data: [String: String]) -> Promise<Void> {
        return Promise<Void> { promise in
            AF.request(self.getURL(method: .post),
                       method: .post,
                       parameters: data,
                       encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseJSON { response in
                        guard let data = try? response.result.get() as? [String: Any] else {
                            #warning("TODO: add promise.reject with error")
                            return
                        }
                        print(data)
                        promise.fulfill(())
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
