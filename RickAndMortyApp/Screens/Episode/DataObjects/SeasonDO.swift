//
//  SeasonDO.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 20/11/24.
//

import Foundation

struct SeasonDO {
    let id = UUID() 
    let name: String
    var episodes: [EpisodeDO]
}
