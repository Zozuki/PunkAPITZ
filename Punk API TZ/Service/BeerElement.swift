//
//  Beer.swift
//  Punk API TZ
//
//  Created by user on 22.06.2021.

import Foundation

// MARK: - BeerElement
class BeerElement: Codable {
    
    let imageURL: String
    let name: String
    let beerDescription: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case name
        case beerDescription = "description"
    }

    init(imageURL: String,  name: String, beerDescription: String) {
        self.imageURL = imageURL
        self.name = name
        self.beerDescription = beerDescription
    }
}

typealias Beer = [BeerElement]
