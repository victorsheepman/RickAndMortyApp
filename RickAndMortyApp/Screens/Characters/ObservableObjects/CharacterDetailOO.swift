//
//  DetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 8/7/24.
//

import Foundation
import Combine


class CharacterDetailOO: ObservableObject {
        @Published var episodes:[EpisodeDO] = []
        @Published var character: CharacterDO?
        
        var cancellables = Set<AnyCancellable>()
        
        var locationId: Int? {
            
            guard let urlString = character?.location.url else { return nil }
            
            return urlString.split(separator: "/").last.flatMap { Int($0) }
        }
        
        var charactersDictionary: [RowItem] {
            character?.toSections() ?? []
        }
        
        
        func fetchCharactersAndEpisodes(from id: Int) {
            
            let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.characters + "/\(id)")!
            
            let cancellable = NetworkManager.shared.fetchData(from: url, responseType: CharacterDO.self)
                   .receive(on: DispatchQueue.main)
                   .sink { completion in
                       switch completion {
                       case .finished:
                           break
                       case .failure(let error):
                           print("error: \(error.localizedDescription)")
                       }
                   } receiveValue: { [weak self] data in
                       self?.character = data
                       let episodesIds = self?.getEpisodesIds(from: data.episode)
                       
                       if let ids = episodesIds {
                           self?.getEpisodes(from: ids)
                       }
                   }
                   
                cancellable.store(in: &cancellables)
        }
        
        private func getEpisodesIds(from episodes: [String]) -> [String] {
            return episodes.compactMap { url in
                return url.split(separator: "/").last.flatMap {String($0)}
                
            }
        }
        
        private func getEpisodes(from ids: [String]) {
           
            let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.episodes + "/\(ids)")!
              
            NetworkManager.shared.fetchData(from: url, responseType: [EpisodeDO].self)
                  .receive(on: DispatchQueue.main)
                  .sink { completion in
                      switch completion {
                      case .finished:
                          break
                      case .failure(let error):
                          print("error: \(error.localizedDescription)")
                      }
                  } receiveValue: { [weak self] data in
                      self?.episodes = data
                      
                  }
                  .store(in: &cancellables)
        }
        
    }


