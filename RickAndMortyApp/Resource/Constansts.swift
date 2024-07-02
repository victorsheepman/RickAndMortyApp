//
//  Constansts.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 3/5/24.
//

import Foundation

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
        static let location    = "Location"
    }
}
