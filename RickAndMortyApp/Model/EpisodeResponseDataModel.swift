//
//  EpisodeResponseDataModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 3/5/24.
//

import Foundation

// MARK: - EpisodeResponseDataModel
struct EpisodeResponseDataModel: Codable {
    let info: InfoDO
    let results: [EpisodeDO]
}

