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
    @State private var name: String        = ""
    @State private var type: String        = ""
    @State private var dimension: String   = ""
   
    let gridLayout = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30)
    ]

    var body: some View {
        HeaderContainer(config: HeaderContainerConfiguration(title: "Location", isFilterPresented: $isPresented)){
            LazyVGrid(columns: gridLayout){
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
        .fullScreenCover(isPresented: $isPresented, onDismiss: { isPresented = false}){
            FilterLocationView(
                name: $name, 
                type: $type,
                dimension: $dimension,
                isPresented: $isPresented,
                manager: locationViewModel
            )
        }
    }
}

#Preview {
    LocationView()
}
