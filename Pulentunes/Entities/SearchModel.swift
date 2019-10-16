//
//  SearchModel.swift
//  Pulentunes
//
//  Created by Diego Alexander Salazar on 10/15/19.
//  Copyright © 2019 Diego Alexander Salazar. All rights reserved.
//

import Foundation

struct SearchGroup: Decodable {
    let resultCount: Int
    let results: [SearchModel]
}

struct SearchModel: Decodable {
    let artistName: String
    let country: String
    let descript: String
    let artworkUrl100: String
    let trackName: String
    let collectionName: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case artworkUrl100
        case trackName
        case country
        case collectionName
        case description
    }
    
    init(from decoder : Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName) ?? ""
        artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100) ?? ""
        trackName = try values.decodeIfPresent(String.self, forKey: .trackName) ?? ""
        country = try values.decodeIfPresent(String.self, forKey: .country) ?? ""
        descript = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        collectionName = try values.decodeIfPresent(String.self, forKey: .collectionName) ?? ""
    }
}
