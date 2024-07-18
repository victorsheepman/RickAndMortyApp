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
    var residents: [String]
    
    var residentIds: [Int] {
        return residents.compactMap { url in
            return url.split(separator: "/").last.flatMap { Int($0) }
        }
    }
    
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
                    
                }
                .frame(maxWidth: .infinity)
            }.frame(height: 139).padding(.top, -50)
            
            Text("Residents")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color("Gray1"))
                .padding(.horizontal, 16)
                .padding(.top, 20)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: layout){
                    ForEach(episodeDetailViewModel.characters, id:\.id){ character in
                        
                        NavigationLink(destination: CharacterDetailView( characterId: character.id, episodes: character.episode)) {
                            CharacterCard(status: character.status, name: character.name, img: character.image)
                        }
                        
                        
                        
                    }
                }
            }
            Spacer()
            
        }
        .onAppear{
            episodeDetailViewModel.getEpisode(from: episodeId)
            episodeDetailViewModel.getResidents(from: residentIds)
            print(residentIds)
        }
        Spacer()
    }
}

#Preview {
    EpisodeDetailView(episodeId: 4, residents: [
        "https://rickandmortyapi.com/api/character/1",
        "https://rickandmortyapi.com/api/character/2",
        "https://rickandmortyapi.com/api/character/38",
        "https://rickandmortyapi.com/api/character/87",
        "https://rickandmortyapi.com/api/character/175",
        "https://rickandmortyapi.com/api/character/179",
        "https://rickandmortyapi.com/api/character/181",
        "https://rickandmortyapi.com/api/character/191",
        "https://rickandmortyapi.com/api/character/239",
        "https://rickandmortyapi.com/api/character/241",
        "https://rickandmortyapi.com/api/character/270",
        "https://rickandmortyapi.com/api/character/337",
        "https://rickandmortyapi.com/api/character/338"
    ])
}
