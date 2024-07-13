//
//  LocationView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/7/24.
//

import SwiftUI

struct LocationView: View {
    @StateObject var locationViewModel = LocationViewModel()
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: layout){
                    ForEach(locationViewModel.locations, id:\.id){ location in
                        
                     
                        LocationCard(type: location.type ?? "", name: location.name ?? "")
                        
                        
                        
                    }
                }
            }
          
            
        }.onAppear{
            
            locationViewModel.getLocations(from: "page=3")
        }
    }
}

#Preview {
    LocationView()
}
