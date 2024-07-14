//
//  LocationView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/7/24.
//

import SwiftUI

struct LocationView: View {
    @StateObject var locationViewModel = LocationViewModel()
   
    @State var isPresented:Bool = false
    
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
            }
          
            
        }.onAppear{
            
            locationViewModel.getLocations(from: "page=3")
        }
    }
}

#Preview {
    LocationView()
}
