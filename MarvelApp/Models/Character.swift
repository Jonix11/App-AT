//
//  Character.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 20/3/21.
//

import Foundation
import ObjectMapper

struct Character: ImmutableMappable {
    
    let charaterId: Int
    let name: String
    let description: String
    let image: [String: String]
    let comics: [[String: String]]
    
    init(map: Map) throws {
        charaterId = try map.value("id")
        name = try map.value("name")
        description = try map.value("description")
        image = try map.value("thumbnail")
        comics = try map.value("comics.items")
    }
}

enum ImageDictionary: String {
    case path = "path"
    case ext = "extension"
}

extension Character: CellItemContract {
    var itemId: Int {
        return self.charaterId
    }

    var itemName: String {
        return self.name
    }

    var itemImage: URL? {
        let path = self.image[ImageDictionary.path.rawValue]
        let ext = self.image[ImageDictionary.ext.rawValue]
        if let strPath = path,
           let strExt = ext {
            let strURL = strPath + strExt
            return URL(string: strURL)
        } else {
            return nil
        }
    }
}
