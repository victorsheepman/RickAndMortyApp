//
//  LocationDetailView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 14/7/24.
//

import SwiftUI


struct LocationDetailView: View {
    
    var locationId: Int

    @StateObject private var locationDetailViewModel = LocationDetailViewModel()
   
    var body: some View {
        VStack(alignment: .leading) {
            banner
            if !locationDetailViewModel.characters.isEmpty {
                Text("Residents")
                    .font(.title3.bold())
                    .foregroundStyle(.gray)
                    .padding([.horizontal,.top])
                CharacterListView(characters: locationDetailViewModel.characters)
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(locationDetailViewModel.location?.name ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .onAppear{
            locationDetailViewModel.fetchLocationAndResidents(from: locationId)
        }
        
    }
    
    var banner: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color("Gray6"))
                .frame(width: geometry.size.width, height: 139)
                .overlay {
                    VStack {
                        Text(locationDetailViewModel.location?.type ?? "")
                            .font(.caption2)
                            .foregroundStyle(.gray2)
                        
                        Text(locationDetailViewModel.location?.name ?? "")
                            .font(.title.bold())
                        
                        Text(locationDetailViewModel.location?.dimension ?? "")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray1)
                    }
                }
            
        }
        .frame(height: 139)
        .padding(.top, -50)
    }
}


#Preview {
    LocationDetailView(locationId: 3)
}
