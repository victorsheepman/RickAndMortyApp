//
//  EpisodeViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 3/5/24.
//

import Foundation
import Combine

class EpisodeViewModel: ObservableObject {

    @Published var episodes:[String: [EpisodeDataModel]] = [:]

    var cancellables = Set<AnyCancellable>()
    let baseUrl = Constansts.MainURL.main + Constansts.Endpoints.episodes + "?"
    
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
                   self?.divideEpisodesBySeason(episodes: episodes) ?? [:]
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
                   self?.episodes = dataModel
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
