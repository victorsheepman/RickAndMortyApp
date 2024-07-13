//
//  LocationResponseDataModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 13/7/24.
//

import Foundation

// MARK: - LocationResponseDataModel
struct LocationResponseDataModel: Codable {
    let info: Info
    let results: [LocationDataModel]
}


// MARK: - Result
struct LocationDataModel: Codable {
    let id: Int?
    let name, type, dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}

