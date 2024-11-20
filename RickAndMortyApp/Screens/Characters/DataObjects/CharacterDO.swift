//
//  CharacterDO.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 19/11/24.
//

import Foundation

// MARK: - Result
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
