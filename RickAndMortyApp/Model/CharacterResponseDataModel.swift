//
//  CharacterResponseDataModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 3/5/24.
//

import Foundation


// MARK: - CharacterResponseDataModel
struct CharacterResponseDO: Codable {
    let info: Info
    let results: [CharacterDO]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}



// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}


struct CharacterFilters {
    var status = String()
    var gender = String()
    var species = String()
    var name = String()
}
