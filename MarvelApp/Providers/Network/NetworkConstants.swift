//
//  NetworkConstants.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 20/3/21.
//

import Foundation

struct NetworkConstants {
    static func getInitialURL() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.path = "/v1/public/"
        
        return components.url!
    }
}
