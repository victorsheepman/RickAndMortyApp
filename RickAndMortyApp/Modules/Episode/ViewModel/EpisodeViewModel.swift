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
        let cancellable = NetworkManager.shared.fetchEpisodeData()
               .receive(on: DispatchQueue.main)
               .sink { completion in
                   switch completion {
                   case .finished:
                       break
                   case .failure(let error):
                       print("error: \(error.localizedDescription)")
                   }
               } receiveValue: { [weak self] episodeDataModel in
                   self?.episodeModel = episodeDataModel
               }
               
            cancellable.store(in: &cancellables)
    }
        
}
