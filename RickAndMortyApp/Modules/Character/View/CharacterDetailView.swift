//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 7/7/24.
//

import SwiftUI


struct CharacterDetailView: View {
    
    @StateObject var detailViewModel = CharacterDetailViewModel()
    
    
    var characterId: Int

    var locationId: Int? {
        
        guard let urlString = detailViewModel.character?.location.url else { return nil }
        
        return urlString.split(separator: "/").last.flatMap { Int($0) }
    }
    
    var body: some View {
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
                                    .stroke(Color("White"), lineWidth: 5)
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
                        .foregroundStyle(.gray2)
                        .padding(.top, 10)
                    
                    Text(detailViewModel.character?.name ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(detailViewModel.character?.species ?? "")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray1)
                    
                }
            }
            .padding(.top, -50)
            
            Text("Informations")
                .font(.title3.bold())
                .foregroundStyle(.gray)
                .padding(.horizontal)
                .padding(.top, 5)
            
            Divider()
            
            VStack(alignment: .leading){
                
                Text("Gender")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text(detailViewModel.character?.gender ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                
                Text("Origin")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text(detailViewModel.character?.origin.name ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                
                Divider()
                
                Text("Type")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text((detailViewModel.character?.type.isEmpty ?? true ? "Unknown" : detailViewModel.character?.type) ?? "Unknown")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                NavigationLink(destination: LocationDetailView(locationId:locationId ?? 0 )) {
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
                
            }.padding(.horizontal, 16)
            Divider()
            
            Text("Episodes")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.gray1)
                .padding(.horizontal, 16)
                .padding(.top, 10)
            Divider()
            ScrollView {
                VStack {
                    ForEach(detailViewModel.episodes, id:\.id) { item in
                        EpisodeCard(
                            episode: item.episode, 
                            id:      item.id,
                            name:    item.episode,
                            airDate: item.airDate
                        )
                        Divider()
                        
                    }
                }                
            }
        }
        .onAppear(){
            
            detailViewModel.fetchCharactersAndEpisodes(from: characterId)
        }
        Spacer()
    }
}

#Preview {
    CharacterDetailView(characterId: 2)
}
