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
            HeaderView(
                caption: viewModel.location?.type ?? "",
                title:   viewModel.location?.name ?? "",
                footnote: viewModel.location?.dimension ?? ""
            )
            if !viewModel.characters.isEmpty {
                Text("Residents")
                    .font(.title3.bold())
                    .foregroundStyle(.gray)
                    .padding([.horizontal,.top])
                CharacterListView(characters: viewModel.characters)
            }
            Spacer()
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
}


#Preview {
    LocationDetailView(locationId: 3)
}
