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
