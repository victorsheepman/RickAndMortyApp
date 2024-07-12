//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 3/5/24.
//


import Foundation
import Combine

class CharacterViewModel: ObservableObject {

    @Published var characterModel:[CharacterDataModel] = []

    var cancellables = Set<AnyCancellable>()
    
    func getCharacters() {
        let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.characters + "/?page=2")!
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType: CharacterResponseDataModel.self)
               .receive(on: DispatchQueue.main)
               .sink { completion in
                   switch completion {
                   case .finished:
                       break
                   case .failure(let error):
                       print("error: \(error.localizedDescription)")
                   }
               } receiveValue: { [weak self] characterDataModel in
                   self?.characterModel =  characterDataModel.results
               }
               
            cancellable.store(in: &cancellables)
    }
    
    func getCharacterFiltered(gender: String? = nil, status: String? = nil, species: String? = nil, name: String? = nil) {
        guard let url = constructURL(gender: gender, status: status, species: species, name: name) else {
            print("Invalid URL")
            return
        }
        
        print(url)
    }
    
    private func constructURL(gender: String?, status: String?, species: String?, name: String?) -> URL? {

        let baseURL = Constansts.MainURL.main + Constansts.Endpoints.characters + "/?"

        
        var queryItems = [URLQueryItem]()
        
       
        if let name = name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        if let status = status, !status.isEmpty {
            queryItems.append(URLQueryItem(name: "status", value: status))
        }
        if let species = species, !species.isEmpty {
            queryItems.append(URLQueryItem(name: "species", value: species))
        }
        if let gender = gender, !gender.isEmpty {
            queryItems.append(URLQueryItem(name: "gender", value: gender))
        }

       
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = queryItems


        return urlComponents?.url
    }
        
}
