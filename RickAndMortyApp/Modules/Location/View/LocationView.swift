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
    
    let layout = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: layout){
                    ForEach(locationViewModel.locations, id:\.id){ location in
                        NavigationLink(destination: LocationDetailView(locationId: location.id ?? 0, residents: location.residents ?? [""])) {
                            LocationCard(type: location.type ?? "", name: location.name ?? "")
                        }
                    }
                }.padding(.top, 19)
                    .padding(.horizontal, 16)
                    .background(.white)
                    .navigationTitle("Location")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                isPresented = true
                            })
                            {
                                Text("Filter")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color("Indigo"))
                            }
                        }
                    }
                
            }.background(Color("Gray7"))
            
        }
        
        .onAppear{
            
            locationViewModel.getLocations(from: "page=3")
        }
        .fullScreenCover(isPresented: $isPresented, onDismiss: { isPresented = false}){
            FilterLocationView(name: $name, type: $type, dimension: $dimension, isPresented: $isPresented, manager: locationViewModel)
        }
    }
}

#Preview {
    LocationView()
}
