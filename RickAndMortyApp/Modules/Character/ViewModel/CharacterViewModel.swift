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
        let cancellable = NetworkManager.shared.fetchCharacterData()
               .receive(on: DispatchQueue.main)
               .sink { completion in
                   switch completion {
                   case .finished:
                       break
                   case .failure(let error):
                       print("error: \(error.localizedDescription)")
                   }
               } receiveValue: { [weak self] weatherModel in
                   self?.characterModel = weatherModel
               }
               
            cancellable.store(in: &cancellables)
    }
        
}
