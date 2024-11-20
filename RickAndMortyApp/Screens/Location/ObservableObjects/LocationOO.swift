//
//  LocationOO.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 19/11/24.
//


import Foundation
import Combine

class LocationOO: ObservableObject {
    
    @Published var locations: [LocationDO] = []

    let baseURL = Constansts.MainURL.main + Constansts.Endpoints.locations + "?"
    
    init() {
        getLocations(from: "page=3")
    }
    
    
    func getLocations(from page: String) {
        guard let url = URL(string: self.baseURL + page) else {
            print("Invalid URL")
            return
        }
        fetchData(url: url)
    }
    
    func getLocationsFiltered(by filter: LocationFilter) {
        guard let url = constructURL(filter) else {
            print("Invalid URL")
            return
        }
        fetchData(url: url)
    }
    
    
    private func fetchData(url:URL) {
        var cancellables = Set<AnyCancellable>()
        let cancellable = NetworkManager.shared.fetchData(from: url, responseType: LocationResponseDO.self)
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
    
    private func constructURL(_ filters: LocationFilter) -> URL? {
        var queryItems: [URLQueryItem] = [
            filters.name.isEmpty      ? nil : URLQueryItem(name: "name",      value: filters.name),
            filters.type.isEmpty      ? nil : URLQueryItem(name: "type",      value: filters.type),
            filters.dimension.isEmpty ? nil : URLQueryItem(name: "dimension", value: filters.dimension),
            
        ].compactMap { $0 }
        
        guard !queryItems.isEmpty else { return nil }
        
        var urlComponents = URLComponents(string: self.baseURL)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}
