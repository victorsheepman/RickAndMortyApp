//
//  EpisodeDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 17/7/24.
//

import Foundation
import Combine

class EpisodeDetailOO: ObservableObject {
    
    @Published var characters: [CharacterDO] = []
    @Published var episode: EpisodeDO?
    
    let baseURL = Constansts.MainURL.main + Constansts.Endpoints.episodes
    
    var cancellables = Set<AnyCancellable>()
    
    func getEpisode(from id: Int) {
        
        guard let url = URL(string: self.baseURL + "/\(id)") else {
            print("Invalid episodes URL")
            return
        }
        
        fetchData(url: url, responseType: EpisodeDO.self) { response in
            switch response {
            case .success(let data):
                self.handleResponse(data)
            case .failure(let error):
                print("Error fetching character: \(error.localizedDescription)")
            }
        }
    }
    
    private func handleResponse(_ data: EpisodeDO) {
        self.episode = data
        let characterIds = data.characters.compactMap { $0.split(separator: "/").last.map(String.init) }
        self.getResidents(from: characterIds)
    }
    
    private func getResidents(from ids: [String]) {
        
        guard let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.characters + "/\(ids)") else {
            print("Invalid episodes URL")
            return
        }
        
        fetchData(url: url, responseType: [CharacterDO].self) { response in
            switch response {
            case .success(let data):
                self.characters = data
            case .failure(let error):
                print("Error fetching character: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchData<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
      
        NetworkManager.shared.fetchData(from: url, responseType: responseType)
            .receive(on: DispatchQueue.main)
            .sink { completionResult in
                switch completionResult {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                    completion(.failure(error)) // Retorna el error si ocurre
                }
            } receiveValue: { data in
                completion(.success(data)) // Retorna los datos
            }
            .store(in: &cancellables)
    }
}





