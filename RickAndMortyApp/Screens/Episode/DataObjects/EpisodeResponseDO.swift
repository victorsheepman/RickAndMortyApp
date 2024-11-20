//
//  EpisodeResponseDO.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 20/11/24.
//

import Foundation

struct EpisodeResponseDO: Codable {
    let info: InfoDO
    let results: [EpisodeDO]
}

