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
        NavigationView {
                list
        }
        .fullScreenCover(isPresented: $isPresented, onDismiss: { isPresented = false}){
            FilterEpisodeView(name:        $name,
                              episode:     $episode,
                              isPresented: $isPresented,
                              manager:     episodeViewModel
            )
        }
    }
    
    var list: some View {
        
        List {
            ForEach(episodeViewModel.seasons, id: \.name) { region in
                Section(header: Text(region.name)
                    .font(.title3.bold())
                    .foregroundStyle(.gray)
                    .padding(.vertical, 5))
                {
                    ForEach(region.episodes, id: \.id) { sea in
                        EpisodeCard(
                            episode: sea.episode,
                            id:      sea.id,
                            name:    sea.name,
                            airDate: sea.airDate
                        )
                    }
                }
            }
            
        }
    }
}



#Preview {
    EpisodeView()
}
