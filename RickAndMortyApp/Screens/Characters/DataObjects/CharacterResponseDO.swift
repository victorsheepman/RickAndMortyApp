//
//  CharacterResponseDO.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 20/11/24.
//

import Foundation

struct CharacterResponseDO: Codable {
    let info: InfoDO
    let results: [CharacterDO]
}
