//
//  LocationViewModel.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/7/24.
//

import Foundation
import Combine

class LocationViewModel: ObservableObject {
    
    @Published var locations:[LocationDataModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    let baseURL = Constansts.MainURL.main + Constansts.Endpoints.locations + "?"
    
    func getLocations(from page: String) {
        let url = URL(string: self.baseURL + page)!
        getDataFromApi(url: url)
    }
    
    private func getDataFromApi(url:URL){
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType: LocationResponseDataModel.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] dataModel in
                
                self?.locations = dataModel.results
            }
        
        cancellable.store(in: &cancellables)
    }
}
