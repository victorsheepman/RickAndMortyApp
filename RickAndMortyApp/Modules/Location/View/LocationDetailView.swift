//
//  LocationDetailView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 14/7/24.
//

import SwiftUI


struct LocationDetailView: View {
    
    var locationId: Int

    @StateObject private var viewModel = LocationDetailViewModel()
   
    var body: some View {
        VStack(alignment: .leading) {
            banner
            if !viewModel.characters.isEmpty {
                Text("Residents")
                    .font(.title3.bold())
                    .foregroundStyle(.gray)
                    .padding([.horizontal,.top])
                CharacterListView(characters: viewModel.characters)
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.location?.name ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .onAppear{
            viewModel.fetchLocationAndResidents(from: locationId)
        }
        
    }
    
    var banner: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color("Gray6"))
                .frame(width: geometry.size.width, height: 139)
                .overlay {
                    VStack {
                        Text(viewModel.location?.type ?? "")
                            .font(.caption2)
                            .foregroundStyle(.gray2)
                        
                        Text(viewModel.location?.name ?? "")
                            .font(.title.bold())
                        
                        Text(viewModel.location?.dimension ?? "")
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
