//
//  StringExtension.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 25/3/21.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        // swiftlint:disable:next line_length
        let regex = "^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailPredicate.evaluate(with: self)
    }
}
