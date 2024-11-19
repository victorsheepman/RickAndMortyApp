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
    
    init() {
        getLocations(from: "page=3")
    }
    
    
    func getLocations(from page: String) {
        let url = URL(string: self.baseURL + page)!
        getDataFromApi(url: url)
    }
    
    func getLocationsFiltered(by filter: LocationFilter) {
        guard let url = constructURL(filter) else {
            print("Invalid URL")
            return
        }
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
    
    private func constructURL(_ filter: LocationFilter) -> URL? {

        var queryItems = [URLQueryItem]()
        
       
        if !filter.name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: filter.name))
        }
        if !filter.type.isEmpty {
            queryItems.append(URLQueryItem(name: "type", value: filter.type))
        }
        if !filter.dimension.isEmpty {
            queryItems.append(URLQueryItem(name: "dimension", value: filter.dimension))
        }
      
        
        var urlComponents = URLComponents(string: self.baseURL)
        urlComponents?.queryItems = queryItems


        return urlComponents?.url
    }
}
