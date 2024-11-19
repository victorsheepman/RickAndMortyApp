//
//  EpisodeViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 3/5/24.
//

import Foundation
import Combine

struct Season  {
    let name: String
    var episodes: [EpisodeDataModel]
}

class EpisodeViewModel: ObservableObject {
    
    @Published var episodes:[String: [EpisodeDataModel]] = [:]
    @Published var seasons: [Season] = []
    
    var cancellables = Set<AnyCancellable>()
    let baseUrl = Constansts.MainURL.main + Constansts.Endpoints.episodes + "?"
    
    init(){
        getEpisodes(from: "page=1")
    }
    
    func getEpisodes(from page: String) {
        let url = URL(string: baseUrl + page)!
        getDataFromApi(url: url)
    }
    
    func getEpisodesFiltered(name: String? = nil, episode: String? = nil) {
        guard let url = constructURL(name: name, episode: episode) else {
            print("Invalid URL")
            return
        }
        getDataFromApi(url: url)
    }
    
    private func getDataFromApi(url:URL){
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType:  EpisodeResponseDataModel.self)
            .map { $0.results }
            .map { [weak self] episodes in
                self?.groupEpisodesBySeason(episodes: episodes) ?? []
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] dataModel in
                DispatchQueue.main.async { // Fuerza el cambio en el hilo principal
                     self?.seasons = dataModel
                 }
            }
        
        cancellable.store(in: &cancellables)
    }
    
    private func divideEpisodesBySeason(episodes: [EpisodeDataModel]) -> [String: [EpisodeDataModel]] {
        var seasons: [String: [EpisodeDataModel]] = [:]
        
        for episode in episodes {
            let seasonPrefix = String(episode.episode.prefix(3)) // "S01" de "S01E01"
            if let seasonNumber = Int(seasonPrefix.dropFirst()) {
                let seasonName = "Season \(seasonNumber)"
                
                if seasons[seasonName] != nil {
                    seasons[seasonName]?.append(episode)
                } else {
                    seasons[seasonName] = [episode]
                }
            }
        }
        
        return seasons
    }
    
    private func groupEpisodesBySeason(episodes: [EpisodeDataModel]) -> [Season] {
        var seasons: [Season] = []
        
        for episode in episodes {
            let seasonPrefix = String(episode.episode.prefix(3)) // "S01" de "S01E01"
            let seasonName = "Season \(seasonPrefix.dropFirst())"
            
            // Verificar si ya existe una temporada con este nombre
            if let index = seasons.firstIndex(where: { $0.name == seasonName }) {
                // Si existe, añadir el episodio a la temporada correspondiente
                var updatedSeason = seasons[index]
                updatedSeason.episodes.append(episode)
                seasons[index] = updatedSeason
            } else {
                // Si no existe, crear una nueva temporada y añadirla al arreglo
                let newSeason = Season(name: seasonName, episodes: [episode])
                seasons.append(newSeason)
            }
        }
        
        return seasons
    }
    
    
    
    
    private func constructURL(name: String?, episode: String?) -> URL? {
        
        var queryItems = [URLQueryItem]()
        
        
        if let name = name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        
        if let episode = episode, !episode.isEmpty {
            queryItems.append(URLQueryItem(name: "episode", value: episode))
        }
        
        var urlComponents = URLComponents(string: self.baseUrl)
        urlComponents?.queryItems = queryItems
        
        
        return urlComponents?.url
    }
}
