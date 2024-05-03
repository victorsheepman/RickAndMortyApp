//
//  EpisodeView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/5/24.
//

import SwiftUI

struct EpisodeView: View {
    @StateObject var episodeViewModel = EpisodeViewModel()
    var body: some View {
        NavigationView {
            List(episodeViewModel.episodeModel, id: \.id) { episode in
                Text(episode.name)
                   }
                   .navigationTitle("Episodes")
               }.onAppear{
           
                   episodeViewModel.getEpisodes()
        }
    }
}

#Preview {
    EpisodeView()
}
