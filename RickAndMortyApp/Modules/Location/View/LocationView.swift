//
//  LocationView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/7/24.
//

import SwiftUI

struct LocationView: View {
    
    @StateObject var locationViewModel = LocationViewModel()
    
    @State private var isPresented: Bool   = false
    
 
    @State private var filter = LocationFilter()
   
   

    var body: some View {
        HeaderContainer(config: HeaderContainerConfiguration(title: "Location", isFilterPresented: $isPresented)){
            LazyVGrid(columns: Constansts.gridLayout){
                ForEach(locationViewModel.locations, id:\.id){ location in
                    NavigationLink(destination: LocationDetailView(locationId: location.id ?? 0)) {
                        LocationCard(type: location.type ?? "", name: location.name ?? "")
                    }
                }
            }.padding(.top, 19)
                .padding(.horizontal, 16)
                .background(.white)
        }.onAppear{
            locationViewModel.getLocations(from: "page=3")
        }
        .fullScreenCover(isPresented: $isPresented){
            FilterLocationView(
                filter: $filter,
                manager: locationViewModel
            )
        }
    }
}

struct LocationFilter {
    var name = String()
    var type = String()
    var dimension = String()
}


#Preview {
    LocationView()
}
