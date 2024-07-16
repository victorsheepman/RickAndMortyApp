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
    let baseUrl = Constansts.MainURL.main + Constansts.Endpoints.episodes
    
    func getEpisodes(from page: String) {
        let url = URL(string: baseUrl + "/?\(page)")!
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
}
