//
//  LocationDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 14/7/24.
//

import Foundation
import Combine

class LocationDetailOO: ObservableObject {
    
    @Published var characters: [CharacterDO] = []
    @Published var location: LocationDO?
    
    let baseURL          = Constansts.MainURL.main + Constansts.Endpoints.locations
    let baseURLCharacter = Constansts.MainURL.main + Constansts.Endpoints.characters
    
    var cancellables = Set<AnyCancellable>()
    
    func getLocations(from id: Int) {
        guard let url = URL(string: self.baseURL + "/\(id)") else {
            print("Invalid URL")
            return
        }
        
        fetchData(url: url, responseType:  LocationDO.self) { response in
            switch response {
            case .success(let response):
                self.handleResponse(response)
            case .failure(let error):
                print("Error fetching character: \(error.localizedDescription)")
            }
        }
    }
    
    private func handleResponse(_ data: LocationDO) {
        self.location = data
        
        
        let residentIds = data.residents?.compactMap { $0.split(separator: "/").last.map(String.init) }
        
        guard let ids = residentIds else {
            return
        }
        
        if !ids.isEmpty {
            self.getResidents(from: ids)
        }
        
        
    }
    
    private func getResidents(from ids: [String]) {
        
        guard let url = URL(string: self.baseURLCharacter + "/\(ids)") else {
            print("Invalid URL")
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

