//
//  EpisodeDetailView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 17/7/24.
//

import SwiftUI

struct EpisodeDetailView: View {
    
    @StateObject private var viewModel = EpisodeDetailViewModel()
    @State private var isPresentingDetailResident   = false
    
    var episodeId: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(
                caption: viewModel.episode?.airDate ?? "",
                title: viewModel.episode?.name ?? "",
                footnote: viewModel.episode?.episode ?? ""
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
                Text(viewModel.episode?.name ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .onAppear{
            viewModel.fetchEpisodeAndCharacters(from: episodeId)
        }
        Spacer()
    }
}

#Preview {
    EpisodeDetailView(episodeId: 4)
}
