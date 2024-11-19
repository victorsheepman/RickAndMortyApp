//
//  EpisodeView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/5/24.
//

import SwiftUI

struct EpisodeView: View {
    @StateObject var episodeViewModel = EpisodeViewModel()
    
    
    @State private var isPresented: Bool    = false
    @State private var name: String         = ""
    @State private var episode: String      = ""
    
    
    var body: some View {
        HeaderContainer(config: HeaderContainerConfiguration(title: "Episode", isFilterPresented: $isPresented)) {
            list
        }
        .fullScreenCover(isPresented: $isPresented, onDismiss: { isPresented = false}){
            FilterEpisodeView(
                name:        $name,
                episode:     $episode,
                isPresented: $isPresented,
                manager:     episodeViewModel
            )
        }
    }
    
    var list: some View {
        List {
            ForEach(episodeViewModel.seasons, id: \.name) { season in
                Section(header: Text(season.name)
                    .font(.title3.bold())
                    .foregroundStyle(.gray)
                    .padding(.vertical, 5))
                {
                    ForEach(season.episodes, id: \.id) { episode in
                        EpisodeCard(
                            episode: episode.episode,
                            id:      episode.id,
                            name:    episode.name,
                            airDate: episode.airDate
                        )
                    }
                }
            }
        }
        .listStyle(.plain)
        .background(.white)
    }
}



#Preview {
    EpisodeView()
}
