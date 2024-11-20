//
//  EpisodeView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/5/24.
//

import SwiftUI

struct EpisodeView: View {
    @StateObject var viewModel = EpisodeOO()
    
    
    @State private var isPresented: Bool    = false
    @State private var filter = EpisodeFilter()
    
    var body: some View {
        HeaderContainer(config: HeaderContainerConfiguration(title: "Episode", isFilterPresented: $isPresented)) {
            list
        }
        .fullScreenCover(isPresented: $isPresented){
            FilterEpisodeView(
                filter: $filter,
                manager: viewModel
            )
        }
    }
    
    var list: some View {
        List {
            ForEach(viewModel.seasons, id: \.id) { season in
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

struct EpisodeFilter {
    var name = String()
    var episode = String()
}





#Preview {
    EpisodeView()
}
