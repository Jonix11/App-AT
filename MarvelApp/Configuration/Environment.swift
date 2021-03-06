//
//  Environment.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 20/3/21.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    // swiftlint:disable all
    enum Keys {
        enum Plist {
            static let env = "APP_ENVIRONMENT"
        }
    }
    // swiftlint:enable all
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    
    static let appEnv: String = {
        guard let appEnv = Environment.infoDictionary[Keys.Plist.env] as? String else {
            fatalError("APP Environment not set in plist for this environment")
        }
        return appEnv
    }()
    
}
