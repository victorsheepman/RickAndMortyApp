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
        print("Se ejecuto getLocation")
    }
    
    func getLocationsFiltered(name: String? = nil, type: String? = nil, dimension: String? = nil) {
        guard let url = constructURL(name: name, type: type, dimension: dimension) else {
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
    
    private func constructURL(name: String?, type: String?, dimension: String?) -> URL? {

        var queryItems = [URLQueryItem]()
        
       
        if let name = name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        if let type = type, !type.isEmpty {
            queryItems.append(URLQueryItem(name: "type", value: type))
        }
        if let dimension = dimension, !dimension.isEmpty {
            queryItems.append(URLQueryItem(name: "dimension", value: dimension))
        }
      
        
        var urlComponents = URLComponents(string: self.baseURL)
        urlComponents?.queryItems = queryItems


        return urlComponents?.url
    }
}
