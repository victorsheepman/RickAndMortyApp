//
//  LocationView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/7/24.
//

import SwiftUI

struct LocationView: View {
    @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        NavigationView {
            List(locationViewModel.locations, id: \.id) { location in
                Text(location.name ?? "")
                   }
                   .navigationTitle("Episodes")
               }.onAppear{
           
                   locationViewModel.getLocations(from: "page=3")
        }
    }
}

#Preview {
    LocationView()
}
