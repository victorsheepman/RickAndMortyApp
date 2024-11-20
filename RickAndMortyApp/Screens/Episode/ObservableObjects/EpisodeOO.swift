//
//  EpisodeOO.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 19/11/24.
//

import Foundation
import Combine


class EpisodeOO: ObservableObject {
    
    @Published var seasons: [SeasonDO] = []
    
   
    let baseURL = Constansts.MainURL.main + Constansts.Endpoints.episodes + "?"
    
    init(){
        getEpisodes(from: "page=1")
    }
    
    func getEpisodes(from page: String) {
        guard let url = URL(string: baseURL + page) else {
            print("Invalid URL")
            return
        }
        fetchData(from: url)
    }
    
    func getEpisodesFiltered(by filter: EpisodeFilter) {
        guard let url = constructURL(name: filter.name, episode: filter.episode) else {
            print("Invalid URL")
            return
        }
        fetchData(from: url)
    }
    
    private func fetchData(from url:URL){
        var cancellables = Set<AnyCancellable>()
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType:  EpisodeResponseDO.self)
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

    private func groupEpisodesBySeason(episodes: [EpisodeDO]) -> [SeasonDO] {
        var seasons: [SeasonDO] = []
        
        for episode in episodes {
            let seasonPrefix = String(episode.episode.prefix(3)) // "S01" de "S01E01"
            let seasonName = "Season \(seasonPrefix.dropFirst())"
            

            if let index = seasons.firstIndex(where: { $0.name == seasonName }) {
              
                var updatedSeason = seasons[index]
                updatedSeason.episodes.append(episode)
                seasons[index] = updatedSeason
            } else {
    
                let newSeason = SeasonDO(name: seasonName, episodes: [episode])
                seasons.append(newSeason)
            }
        }
        
        return seasons
    }

    private func constructURL(name: String, episode: String) -> URL? {
        var queryItems: [URLQueryItem] = [
            name.isEmpty    ? nil : URLQueryItem(name: "name",    value: name),
            episode.isEmpty ? nil : URLQueryItem(name: "status",  value: episode)
        ].compactMap { $0 }
        
        guard !queryItems.isEmpty else { return nil }
        
        var urlComponents = URLComponents(string: self.baseURL)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}
