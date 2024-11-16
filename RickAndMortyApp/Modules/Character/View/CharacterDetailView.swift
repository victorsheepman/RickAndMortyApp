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
            banner
            
          /*  Text("Informations")
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
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            Text(detailViewModel.character?.location.name ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                
            }.padding(.horizontal, 16)
           */
           list

            Divider()
            
            Text("Episodes")
                .font(.title3.bold())
                .foregroundStyle(.gray)
                .padding(.horizontal)
                .padding(.top, 5)
            
            Divider()
            ScrollView {
                LazyVStack {
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
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(detailViewModel.character?.name ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .onAppear(){
            
            detailViewModel.fetchCharactersAndEpisodes(from: characterId)
        }
        Spacer()
    }
    
    var banner: some View {
        ZStack {
           
            VStack(spacing: 0){
                Image("Banner")
                    .resizable()
                    .frame(height: 84)
                    .blur(radius: 2)
                Rectangle()
                    .fill(Color("Gray6"))
                    .frame(width:.infinity, height: 170)
            }
            
            VStack {
                
                CharacterImageView(imageUrl: detailViewModel.character?.image ?? "")
                
                Text(detailViewModel.character?.status ?? "")
                    .font(.caption2)
                    .foregroundStyle(.gray2)
                    .padding(.top, 10)
                   
                
                Text(detailViewModel.character?.name ?? "")
                    .font(.title.bold())
                
                Text(detailViewModel.character?.species ?? "")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray1)
            }
           
        }
        .padding(.top, -50)
    }
    
    var list: some View {
        List {
            Section(header: Text("Información")
                .font(.title3.bold())
                .foregroundStyle(.gray)
                .padding(.vertical, 5)) {
                    InfoRowView(title: "Gender", value: detailViewModel.character?.gender)
                    InfoRowView(title: "Origin", value: detailViewModel.character?.origin.name)
                    InfoRowView(
                        title: "Type",
                        value: (detailViewModel.character?.type.isEmpty ?? true ? "Unknown" : detailViewModel.character?.type)
                    )
                    NavigationLink(destination: LocationDetailView(locationId: locationId ?? 0)) {
                        InfoRowView(
                            title: "Location",
                            value: detailViewModel.character?.location.name
                        )
                    }
                }
        }.listStyle(.plain)
    }
    
}


fileprivate struct CharacterImageView: View {
    let imageUrl: String
    
    @ViewBuilder
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                placeholderImage
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 130, height: 130)
                    .clipShape(RoundedRectangle(cornerRadius: 110))
                    .overlay(
                        RoundedRectangle(cornerRadius: 110)
                            .stroke(Color("White"), lineWidth: 5)
                    )
            case .failure:
                placeholderImage
            @unknown default:
                placeholderImage
            }
        }
    }
    
    private var placeholderImage: some View {
        Image("image")
            .resizable()
            .frame(width: 130, height: 130)
            .clipShape(RoundedRectangle(cornerRadius: 110))
            .overlay(
                RoundedRectangle(cornerRadius: 110)
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}

fileprivate struct InfoRowView: View {
    var title: String
    var value: String?
    
    var body: some View {
        VStack(alignment:.leading){
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            
            Text(value ?? "Unkown")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}



#Preview {
    CharacterDetailView(characterId: 2)
}
