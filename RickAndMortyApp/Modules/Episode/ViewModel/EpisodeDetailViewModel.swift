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
    
    @Published var characters: [CharacterDataModel] = []
    @Published var episode: EpisodeDataModel?
    
    let baseURL = Constansts.MainURL.main + Constansts.Endpoints.episodes
    
    var cancellables = Set<AnyCancellable>()
    
    func fetchEpisodeAndCharacters(from id: Int) {
        
        let url = URL(string: self.baseURL + "/\(id)")!
        
        NetworkManager.shared.fetchData(from: url, responseType: EpisodeDataModel.self)
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
                let characterIds = self?.getCharacterIds(from: data.characters) ?? []
                self?.getResidents(from: characterIds)

            }
            .store(in: &cancellables)
    }

    private func getCharacterIds(from characters: [String]) -> [String] {
        return characters.compactMap { url in
            return url.split(separator: "/").last.flatMap { String($0) }
        }
    }
    
   
    private func getResidents(from ids: [String]) {
       
        let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.characters + "/\(ids)")!
        
        NetworkManager.shared.fetchData(from: url, responseType: [CharacterDataModel].self)
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
            .store(in: &cancellables)
    }
}





