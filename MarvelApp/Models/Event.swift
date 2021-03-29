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
    let title: String
    let description: String
    let startDate: String
    let image: [String: String]
    let comics: [[String: String]]
    
    init(map: Map) throws {
        eventId = try map.value("id")
        title = try map.value("title")
        description = try map.value("description")
        startDate = try map.value("start")
        image = try map.value("thumbnail")
        comics = try map.value("comics.items")
    }
}

extension Event: CellItemContract {
    
    var itemId: Int {
        return self.eventId
    }

    var itemName: String {
        return self.title
    }

    var itemImage: URL? {
        let path = self.image[ImageDictionary.path]
        let ext = self.image[ImageDictionary.ext]
        if let strPath = path,
           let strExt = ext {
            let strURL = strPath + "." + strExt
            return URL(string: strURL)
        } else {
            return nil
        }
    }
    
    var itemDate: Date? {
        return DateFormatter().date(from: startDate)
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
