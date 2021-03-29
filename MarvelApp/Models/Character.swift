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
    let modifiedDate: String
    let image: [String: String]
    let comics: [[String: String]]
    
    init(map: Map) throws {
        charaterId = try map.value("id")
        name = try map.value("name")
        description = try map.value("description")
        modifiedDate = try map.value("modified")
        image = try map.value("thumbnail")
        comics = try map.value("comics.items")
    }
}

enum ImageDictionary {
    static let path = "path"
    static let ext = "extension"
}

enum ComicsDictionary {
    static let name = "name"
}

extension Character: CellItemContract {
    
    var itemId: Int {
        return self.charaterId
    }

    var itemName: String {
        return self.name
    }

    var itemImage: URL? {
        let path = self.image[ImageDictionary.path]
        let ext = self.image[ImageDictionary.ext]
        if let strPath = path,
           let strExt = ext {
            let strURL = strPath + strExt
            return URL(string: strURL)
        } else {
            return nil
        }
    }
    
    var itemDate: Date? {
        return DateFormatter().date(from: modifiedDate)
    }
}

extension Character: ItemDetailContract {
    var itemDescription: String {
        return description
    }
    
    var itemComics: [String] {
        var arrayComics = [String]()
        for comic in self.comics {
            if let comicStr = comic[ComicsDictionary.name] {
                arrayComics.append(comicStr)
            }
        }
        return arrayComics
    }
}
