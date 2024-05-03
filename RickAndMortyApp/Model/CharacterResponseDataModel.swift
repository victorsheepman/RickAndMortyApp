//
//  CharacterResponseDataModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 3/5/24.
//

import Foundation


// MARK: - CharacterResponseDataModel
struct CharacterResponseDataModel: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}
