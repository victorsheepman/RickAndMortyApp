//
//  EpisodeViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 3/5/24.
//

import Foundation
import Combine

class EpisodeViewModel: ObservableObject {

    @Published var episodeModel:[EpisodeDataModel] = []

    var cancellables = Set<AnyCancellable>()
    
    func getEpisodes() {
        let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.episodes + "/?page=2")!
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType: EpisodeResponseDataModel.self)
               .receive(on: DispatchQueue.main)
               .sink { completion in
                   switch completion {
                   case .finished:
                       break
                   case .failure(let error):
                       print("error: \(error.localizedDescription)")
                   }
               } receiveValue: { [weak self] episodeDataModel in
                   self?.episodeModel = episodeDataModel.results
               }
               
            cancellable.store(in: &cancellables)
    }
        
}
