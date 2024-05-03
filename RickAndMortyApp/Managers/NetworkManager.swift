//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 3/5/24.
//

import Foundation

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
       /*func fetchWeatherData(for city: String) -> Future<WeatherDataModel, Error> {
           let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=97d162391ba73630b4a02aa1cebd2e88&units=metric&lang=es")!
           
           return Future<WeatherDataModel, Error> { promise in
               URLSession.shared.dataTask(with: url) { data, response, error in
                   if let error = error {
                       promise(.failure(error))
                   } else if let data = data {
                       do {
                           let decodedData = try JSONDecoder().decode(WeatherDataModel.self, from: data)
                           promise(.success(decodedData))
                       } catch {
                           promise(.failure(error))
                       }
                   }
               }.resume()
           }
       }*/
}
