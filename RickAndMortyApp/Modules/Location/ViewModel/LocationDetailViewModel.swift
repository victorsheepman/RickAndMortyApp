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
    
    let baseURL = Constansts.MainURL.main + Constansts.Endpoints.locations
    
    var cancellables = Set<AnyCancellable>()
    
    // Función para obtener los IDs de los residentes
    private func getResidentIds(from residents: [String]) -> [Int] {
        return residents.compactMap { url in
            return url.split(separator: "/").last.flatMap { Int($0) }
        }
    }
    
    // Función para obtener los detalles de los personajes a partir de los IDs
    private func getResidents(from ids: [Int]) {
        let idsString = ids.map { String($0) }.joined(separator: ",")
        let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.characters + "/\(idsString)")!
        
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
                print(data)
            }
            .store(in: &cancellables)
    }
    
    // Función para obtener la ubicación y luego los personajes
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
                    self?.getResidents(from: residentIds)
                }
            }
            .store(in: &cancellables)
    }
}

