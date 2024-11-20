//
//  CharacterDO.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 19/11/24.
//

import Foundation


struct CharacterDO: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}


struct Location: Codable {
    let name: String
    let url: String
}
