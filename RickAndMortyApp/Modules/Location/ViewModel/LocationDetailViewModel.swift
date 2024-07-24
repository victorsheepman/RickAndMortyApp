//
//  LocationDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 14/7/24.
//

import Foundation
import Combine

class LocationDetailViewModel: ObservableObject {
    
    @Published var characters: [CharacterDataModel] = []
    @Published var location: LocationDataModel?
    
    let baseURL          = Constansts.MainURL.main + Constansts.Endpoints.locations
    let baseURLCharacter = Constansts.MainURL.main + Constansts.Endpoints.characters
    var cancellables     = Set<AnyCancellable>()
    
    func fetchLocationAndResidents(from id: Int) {
        let url = URL(string: self.baseURL + "/\(id)")!
        
        NetworkManager.shared.fetchData(from: url, responseType: LocationDataModel.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] data in
                self?.location = data
                
                if let residents = data.residents {
                    let residentIds = self?.getResidentIds(from: residents) ?? []
                    
                    if residentIds.count == 1 {
                        self?.getResident(from: residentIds[0])
                    } else {
                        self?.getResidents(from: residentIds)
                    }
                    
                }
            }
            .store(in: &cancellables)
    }
    
    
    private func getResidentIds(from residents: [String]) -> [String] {
        return residents.compactMap { url in
            return url.split(separator: "/").last.flatMap  { String($0) }
        }
    }
    
    
    private func getResidents(from ids: [String]) {
        
        let url = URL(string: self.baseURLCharacter + "/\(ids)")!
        
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
    
    private func getResident(from id: String) {
        
        let url = URL(string: self.baseURLCharacter + "/\(id)")!
        
        NetworkManager.shared.fetchData(from: url, responseType: CharacterDataModel.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] data in
                
                self?.characters.append(data)
                
            }
            .store(in: &cancellables)
    }
}

