//
//  CharactersOO.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 19/11/24.
//


import Foundation
import Combine

class CharacterOO: ObservableObject {
    
    @Published var characterModel:[CharacterDO] = []
    
    var cancellables = Set<AnyCancellable>()
    
    let baseURL = Constansts.MainURL.main + Constansts.Endpoints.characters + "/?"
    
    init() {
        getCharacters(from: "page=19")
    }
    
    func getCharacters(from page: String) {
        let url = URL(string: self.baseURL + page)!
        getDataFromApi(url: url)
    }
    
    func getCharacterFiltered(by filters: CharacterFilter) {
        guard let url = constructURL(filters) else {
            print("Invalid URL")
            return
        }
        getDataFromApi(url: url)
    }
    
    
    private func getDataFromApi(url:URL){
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType: CharacterResponseDO.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] characterDO in
                self?.characterModel =  characterDO.results
                
            }
        
        cancellable.store(in: &cancellables)
    }
    
    private func constructURL(_ filters: CharacterFilter) -> URL? {
        
        var queryItems = [URLQueryItem]()
        
        if !filters.name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: filters.name))
        }
        if !filters.status.isEmpty {
            queryItems.append(URLQueryItem(name: "status", value: filters.status))
        }
        if !filters.species.isEmpty {
            queryItems.append(URLQueryItem(name: "species", value: filters.species))
        }
        if !filters.gender.isEmpty {
            queryItems.append(URLQueryItem(name: "gender", value: filters.gender))
        }
        
        
        var urlComponents = URLComponents(string: self.baseURL)
        urlComponents?.queryItems = queryItems
        
        return urlComponents?.url
    }
    
}


