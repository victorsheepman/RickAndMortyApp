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
            VStack(alignment: .leading){
                ForEach(Array(episodeViewModel.episodes.keys).sorted(), id: \.self) { season in
                    Text(season)
                        .foregroundStyle(Color("Gray1"))
                        .fontWeight(.bold)
                        .font(.title3)
                        .padding(.top, 20)
                        .padding(.horizontal, 16)
                    
                    Divider()
                    
                    ForEach(episodeViewModel.episodes[season] ?? [], id: \.id) { item in
                        EpisodeCard(
                            episode: item.episode,
                            id:      item.id,
                            name:    item.name,
                            airDate: item.airDate
                        )
                        Divider()
                    }
                }
            }
            .background(.white)
            
        }
        
        .onAppear{
            
            episodeViewModel.getEpisodes(from: "")
        }
        .fullScreenCover(isPresented: $isPresented, onDismiss: { isPresented = false}){
            FilterEpisodeView(name:        $name,
                              episode:     $episode,
                              isPresented: $isPresented,
                              manager:     episodeViewModel
            )
        }
    }
}



#Preview {
    EpisodeView()
}
