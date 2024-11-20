//
//  LocationResponseDO.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 20/11/24.
//

import Foundation

// MARK: - LocationResponseDataModel
struct LocationResponseDO: Codable {
    let info: InfoDO
    let results: [LocationDO]
}

