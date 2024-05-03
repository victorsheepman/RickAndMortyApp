//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 3/5/24.
//

import Foundation

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
       func fetchCharacterData() -> Future<[CharacterDataModel], Error> {
           let url = URL(string: Constansts.MainURL.main+Constansts.Endpoints.characters+"/?page=18")!
           
           return Future<[CharacterDataModel], Error> { promise in
               URLSession.shared.dataTask(with: url) { data, response, error in
                   if let error = error {
                       promise(.failure(error))
                   } else if let data = data {
                       do {
                           let decodedData = try JSONDecoder().decode(CharacterResponseDataModel.self, from: data)
                           promise(.success(decodedData.results))
                       } catch {
                           promise(.failure(error))
                       }
                   }
               }.resume()
           }
       }
    
    func fetchEpisodeData() -> Future<[EpisodeDataModel], Error> {
        let url = URL(string: Constansts.MainURL.main+Constansts.Endpoints.episodes+"/?page=2")!
        
        return Future<[EpisodeDataModel], Error> { promise in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(EpisodeResponseDataModel.self, from: data)
                        promise(.success(decodedData.results))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }.resume()
        }
    }
}
