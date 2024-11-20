//
//  CharactersOO.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 19/11/24.
//


import Foundation
import Combine

class CharacterOO: ObservableObject {
    
    @Published var characters: [CharacterDO] = []
    
    var cancellables = Set<AnyCancellable>()
    
    let baseURL = Constansts.MainURL.main + Constansts.Endpoints.characters + "/?"
    
    init() {
        getCharacters(from: "page=19")
    }
    
    func getCharacters(from page: String) {
        guard let url = URL(string: self.baseURL + page) else {
            print("Invalid URL")
            return
        }
        fetchData(from: url)
    }
    
    func getCharacterFiltered(by filters: CharacterFilter) {
        guard let url = constructURL(filters) else {
            print("Invalid URL")
            return
        }
        fetchData(from: url)
    }
    
    private func fetchData(from url: URL) {
        NetworkManager.shared.fetchData(from: url, responseType: CharacterResponseDO.self)
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                self?.characters = response
            }
            .store(in: &cancellables)
    }
    
    private func constructURL(_ filters: CharacterFilter) -> URL? {
        var queryItems: [URLQueryItem] = [
            filters.name.isEmpty    ? nil : URLQueryItem(name: "name",    value: filters.name),
            filters.status.isEmpty  ? nil : URLQueryItem(name: "status",  value: filters.status),
            filters.species.isEmpty ? nil : URLQueryItem(name: "species", value: filters.species),
            filters.gender.isEmpty  ? nil : URLQueryItem(name: "gender",  value: filters.gender)
        ].compactMap { $0 }
        
        guard !queryItems.isEmpty else { return nil }
        
        var urlComponents = URLComponents(string: self.baseURL)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
}


