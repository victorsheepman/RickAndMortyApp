//
//  Constansts.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 24/7/24.
//

import Foundation
import SwiftUI

struct Constansts {
    struct MainURL{
        static let main = "https://rickandmortyapi.com/api"
    }
    struct Endpoints {
        static let characters = "/character"
        static let locations  = "/location"
        static let episodes   = "/episode"
    }
    struct TabTitle{
        static let episode    = "Episodios"
        static let character  = "Character"
        static let favorite   = "Favoritos"
        static let setting    = "Ajustes"
        static let location   = "Location"
    }
    
    static let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
}
