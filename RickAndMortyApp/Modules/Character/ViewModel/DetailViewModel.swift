//
//  DetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 8/7/24.
//

import Foundation
import Combine

class DetailCharacterViewModel: ObservableObject {
    @Published var episodes:[EpisodeDataModel] = []

    var cancellables = Set<AnyCancellable>()
    
    func getEpisodes(episodes:[String]) {
        
        let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.episodes + "/\(episodes)")!
        
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType: CharacterResponseDataModel.self)
               .receive(on: DispatchQueue.main)
               .sink { completion in
                   switch completion {
                   case .finished:
                       break
                   case .failure(let error):
                       print("error: \(error.localizedDescription)")
                   }
               } receiveValue: { [weak self] episodes in
                   print(episodes)
               }
               
            cancellable.store(in: &cancellables)
    }
}
