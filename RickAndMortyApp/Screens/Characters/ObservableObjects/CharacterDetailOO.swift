//
//  DetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 8/7/24.
//

import Foundation
import Combine


class CharacterDetailOO: ObservableObject {
    @Published var episodes:[EpisodeDO] = []
    @Published var character: CharacterDO?
    
    var cancellables = Set<AnyCancellable>()
    
    var locationId: Int? {
        
        guard let urlString = character?.location.url else { return nil }
        
        return urlString.split(separator: "/").last.flatMap { Int($0) }
    }
    
    var charactersDictionary: [RowItem] {
        character?.toSections() ?? []
    }
    
    
    func getCharacter(from id: Int) {
        let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.characters + "/\(id)")!
        
        fetchData(url: url, responseType: CharacterDO.self) { response in
            switch response {
            case .success(let response):
                self.handleResponse(response)
            case .failure(let error):
                print("Error fetching character: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func handleResponse(_ data: CharacterDO) {
        self.character = data
        let episodeIds = getEpisodeIds(from: data.episode)
        if !episodeIds.isEmpty {
            getEpisodes(from: episodeIds)
        }
    }
    
    private func getEpisodeIds(from episodes: [String]) -> [String] {
        return episodes.compactMap { $0.split(separator: "/").last.map(String.init) }
    }
    
    private func getEpisodes(from ids: [String]) {
        guard !ids.isEmpty else {
            print("No episode IDs to fetch")
            return
        }
        
        guard let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.episodes + "/\(ids)") else {
            print("Invalid episodes URL")
            return
        }
        
        fetchData(url: url, responseType: [EpisodeDO].self) { response in
            switch response {
            case .success(let episodes):
                self.episodes = episodes
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


