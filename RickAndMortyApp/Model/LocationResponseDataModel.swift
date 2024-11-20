//
//  LocationResponseDataModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 13/7/24.
//

import Foundation

// MARK: - LocationResponseDataModel
struct LocationResponseDO: Codable {
    let info: Info
    let results: [LocationDO]
}

