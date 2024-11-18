//
//  EpisodeDetailView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 17/7/24.
//

import SwiftUI

struct EpisodeDetailView: View {
    
    @StateObject private var episodeDetailViewModel = EpisodeDetailViewModel()
    @State private var isPresentingDetailResident   = false
    
    var episodeId: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                VStack {
                    Rectangle()
                        .fill(Color("Gray6"))
                        .frame(width: geometry.size.width, height: 139)
                        .overlay {
                            VStack {
                                Text(episodeDetailViewModel.episode?.airDate ?? "")
                                    .font(.caption)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.gray2)
                                
                                Text(episodeDetailViewModel.episode?.name ?? "")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text(episodeDetailViewModel.episode?.episode ?? "")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.gray1)
                            }
                        }
                    
                }.frame(maxWidth: .infinity)
            }.frame(height: 139).padding(.top, -50)
            
            Text("Residents")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color("Gray1"))
                .padding(.horizontal, 16)
                .padding(.top, 20)
            
            CharacterListView(characters: episodeDetailViewModel.characters)
            Spacer()
        }
        .onAppear{
            episodeDetailViewModel.fetchEpisodeAndCharacters(from: episodeId)
        }
        Spacer()
    }
}

#Preview {
    EpisodeDetailView(episodeId: 4)
}
