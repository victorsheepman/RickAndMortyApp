//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 3/5/24.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    func fetchData<T: Decodable>(from url: URL, responseType: T.Type) -> Future<T, Error> {
        return Future<T, Error> { promise in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                } else if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(responseType, from: data)
                        promise(.success(decodedData))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }.resume()
        }
    }
}
