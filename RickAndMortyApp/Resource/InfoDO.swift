//
//  InfoDO.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 20/11/24.
//

import Foundation

// MARK: - Info
struct InfoDO: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}
