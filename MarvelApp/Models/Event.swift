//
//  Event.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 29/3/21.
//

import Foundation
import ObjectMapper

struct Event: ImmutableMappable {
    
    let eventId: Int
    let name: String
    let description: String
    let image: [String: String]
    let comics: [[String: String]]
    
    init(map: Map) throws {
        eventId = try map.value("id")
        name = try map.value("name")
        description = try map.value("description")
        image = try map.value("thumbnail")
        comics = try map.value("comics.items")
    }
}

extension Event: CellItemContract {
    var itemId: Int {
        return self.eventId
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
}

extension Event: ItemDetailContract {
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
