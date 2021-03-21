//
//  ModelContract.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 21/3/21.
//

import Foundation

protocol CellItemContract {
    var itemId: Int { get }
    var itemName: String { get }
    var itemImage: URL? { get }
}
