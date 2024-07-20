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
    @Published var character: CharacterDataModel?
    
    var cancellables = Set<AnyCancellable>()
    
    func getEpisodes(episodes:[Int]) {
        
        let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.episodes + "/\(episodes)")!
        print(url)
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType: [EpisodeDataModel].self)
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
               
            cancellable.store(in: &cancellables)
    }
    
    func getCharacter(from id: Int) {
        
        let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.characters + "/\(id)")!
        
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType: CharacterDataModel.self)
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
               }
               
            cancellable.store(in: &cancellables)
    }
    
    
}
