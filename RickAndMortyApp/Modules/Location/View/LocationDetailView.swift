//
//  LocationDetailView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 14/7/24.
//

import SwiftUI

let layout = [
    GridItem(.flexible()),
    GridItem(.flexible())
]



struct LocationDetailView: View {
    
    @StateObject private var locationDetailViewModel = LocationDetailViewModel()
    @State private var isPresentingDetailResident = false
    
    var locationId: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                VStack {
                    Rectangle()
                        .fill(Color("Gray6"))
                        .frame(width: geometry.size.width, height: 139)
                        .overlay {
                            VStack {
                                Text(locationDetailViewModel.location?.type ?? "")
                                    .font(.caption)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.gray2)
                                
                                Text(locationDetailViewModel.location?.name ?? "")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text(locationDetailViewModel.location?.dimension ?? "")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.gray1)
                            }
                        }
                    
                }
                .frame(maxWidth: .infinity)
            }.frame(height: 139).padding(.top, -50)
            
            Text("Residents")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color("Gray1"))
                .padding(.horizontal, 16)
                .padding(.top, 20)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: layout){
                    ForEach(locationDetailViewModel.characters, id:\.id){ character in
                        NavigationLink(destination: CharacterDetailView( characterId: character.id)) {
                            
                            CharacterCard(
                                status: character.status,
                                name: character.name,
                                img: character.image
                            )
                        }
                    }
                }
            }
            
            
        }
        .onAppear{
            locationDetailViewModel.fetchLocationAndResidents(from: locationId)
            print(locationId)
        }
        Spacer()
    }
}


#Preview {
    LocationDetailView(locationId: 3)
}
