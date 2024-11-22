//
//  LocationDO.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 19/11/24.
//

import Foundation


// MARK: - Result
struct LocationDO: Codable {
    let id: Int?
    let name, type, dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}

