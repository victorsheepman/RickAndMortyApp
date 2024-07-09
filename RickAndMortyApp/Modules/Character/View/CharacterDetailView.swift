//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 7/7/24.
//

import SwiftUI


struct CharacterDetailView: View {

    @StateObject var detailViewModel = DetailCharacterViewModel()
    
    var characterId: Int
    var episodes: [String]
    var episodeIds: [String] {
        return episodes.compactMap { url in
            return url.split(separator: "/").last.map(String.init)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading){
                ZStack{
                    
                    VStack(spacing: 0){
                        
                        Image("Banner")
                            .resizable()
                            .frame(width:.infinity, height: 84)
                        Rectangle()
                            .fill(Color("Gray6"))
                            .frame(width:.infinity, height: 170)
                    }
                    VStack{
                        
                        AsyncImage(url:URL(string: detailViewModel.character?.image ?? "")){ phase in
                            phase
                                .resizable()
                                .frame(width: 130, height: 130)
                                .clipShape(RoundedRectangle(cornerRadius: 110))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 110)
                                        .stroke(Color("White"), lineWidth: 2)
                                )
                        }placeholder: {
                            Image("image")
                                .resizable()
                                .frame(width: 130, height: 130)
                                .clipShape(RoundedRectangle(cornerRadius: 110))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 110)
                                        .stroke(Color("White"), lineWidth: 2)
                                )

                        }
                        
                        Text(detailViewModel.character?.status ?? "")
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundStyle(.gray3)
                            .padding(.top, 10)
                        
                        Text(detailViewModel.character?.name ?? "")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Human")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray1)
                        
                    }
                }
                Text("Informations")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray1)
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                Divider()
                VStack(alignment: .leading){
                    
                    Text("Gender")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Text(detailViewModel.character?.gender ?? "")
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                    
                    Divider()
                    
                    Text("Type")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Text(detailViewModel.character?.type ?? "Unknow")
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                    
                    Divider()
                    NavigationLink(destination: DetailView()) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Location")
                                    .font(.system(size: 17))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                Text(detailViewModel.character?.location.name ?? "")
                                    .font(.caption)
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.gray)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    
                    List(detailViewModel.episodes, id:\.id) { item in
                        NavigationLink(destination: DetailView()) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.episode)
                                        .font(.system(size: 17))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                    
                                    Text(item.episode)
                                        .font(.caption)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.gray)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                }.padding(.horizontal, 16)
                Divider()
                
               
                
            }.onAppear(){
                detailViewModel.getEpisodes(episodes: episodeIds)
                detailViewModel.getCharacter(from: characterId)
            }
        }
    }
}
struct DetailView: View {
    var body: some View {
        Text("Detail View")
            .font(.largeTitle)
            .navigationTitle("Details")
    }
}

#Preview {
    CharacterDetailView(characterId: 2, episodes: [
        "https://rickandmortyapi.com/api/episode/1",
        "https://rickandmortyapi.com/api/episode/2",
    ])
}