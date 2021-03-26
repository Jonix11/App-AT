//
//  NetworkConstants.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 20/3/21.
//

import Foundation

struct NetworkConstants {
    
    static func getHttpbinInitialURL() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "httpbin.org"
        
        // Como la URL la estoy creando yo y en caso de que se forme de forma incorrecta o no sea la URL
        // que necesito quiero que me falle, hago el unwrap forzado.
        return components.url!
    }
    
    static func getMarvelInitialURL() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.path = "/v1/public/"
        let apiKey = URLQueryItem(name: "apikey", value: NetworkInfo.apiKey)
        let hash = URLQueryItem(name: "hash", value: NetworkInfo.hash)
        let ts = URLQueryItem(name: "ts", value: NetworkInfo.ts)
        components.queryItems = [apiKey, hash, ts]
        
        // Como la URL la estoy creando yo y en caso de que se forme de forma incorrecta o no sea la URL
        // que necesito quiero que me falle, hago el unwrap forzado.
        return components.url!
    }
}

// El Enum NetworkInfo lo uso para leer la apiKey, hash y timestamp del archivo NetworkInfo.plist que no subo a git.
// Lo uso en la función de arriba para añadirlos en los queryparams. No sé si es el lugar apropiado para poner esto,
// pero como no sabía donde ponerlo, lo he definido aquí.
enum NetworkInfo {
    // MARK: - Keys
    // swiftlint:disable all
    enum Keys {
        enum Plist {
            static let apiKey = "API_KEY"
            static let hash = "HASH"
            static let ts = "TS"
        }
    }
    // swiftlint:enable all
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let infoPlistPath = Bundle.main.path(forResource: "NetworkInfo", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: infoPlistPath) as? [String: Any] else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let apiKey: String = {
        guard let apiKey = NetworkInfo.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("API Key not set in NetworkInfo.plist")
        }
        return apiKey
    }()
    
    static let hash: String = {
        guard let hash = NetworkInfo.infoDictionary[Keys.Plist.hash] as? String else {
            fatalError("Hash Key not set in NetworkInfo.plist")
        }
        return hash
    }()
    
    static let ts: String = {
        guard let ts = NetworkInfo.infoDictionary[Keys.Plist.ts] as? String else {
            fatalError("Timestamp Key not set in NetworkInfo.plist")
        }
        return ts
    }()
    
}
