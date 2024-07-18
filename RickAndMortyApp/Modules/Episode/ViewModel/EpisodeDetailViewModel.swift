//
//  EpisodeDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 17/7/24.
//

import Foundation

import Foundation
import Combine

class EpisodeDetailViewModel: ObservableObject {
    @Published var characters:[CharacterDataModel] = []
    @Published var episode: EpisodeDataModel?
    
    let baseURL = Constansts.MainURL.main + Constansts.Endpoints.episodes
    
    var cancellables = Set<AnyCancellable>()
    
    func getResidents(from ids:[Int]) {
        
        let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.characters + "/\(ids)")!
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType: [CharacterDataModel].self)
               .receive(on: DispatchQueue.main)
               .sink { completion in
                   switch completion {
                   case .finished:
                       break
                   case .failure(let error):
                       print("error: \(error.localizedDescription)")
                   }
               } receiveValue: { [weak self] data in
                
                   self?.characters = data
                   
               }
               
            cancellable.store(in: &cancellables)
    }
    
    
    func getEpisode(from id: Int) {
        
        let url = URL(string: self.baseURL + "/\(id)")!
        
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType: EpisodeDataModel.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] data in
                self?.episode = data
            }
        
        cancellable.store(in: &cancellables)
    }
    
}
