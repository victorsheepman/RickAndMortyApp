//
//  LocationDetailViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 14/7/24.
//

import Foundation
import Combine

class LocationDetailViewModel: ObservableObject {
    @Published var characters:[CharacterDataModel] = []
    @Published var location: LocationDataModel?
    
    let baseURL = Constansts.MainURL.main + Constansts.Endpoints.locations
    
    var cancellables = Set<AnyCancellable>()
    
    func getResidents(from ids:[Int]) {
        
        let url = URL(string: Constansts.MainURL.main + Constansts.Endpoints.characters + "/\(ids)")!
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType: [CharacterDataModel].self)
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
               
            cancellable.store(in: &cancellables)
    }
    
    
    func getLocation(from id: Int) {
        
        let url = URL(string: self.baseURL + "/\(id)")!
        
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType: LocationDataModel.self)
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
            }
        
        cancellable.store(in: &cancellables)
    }
    
}
