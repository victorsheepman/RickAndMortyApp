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
    
    var charactersDictionary: [RowItem] {
        detailViewModel.character?.toSections() ?? []
    }
    
    var body: some View {
        VStack(alignment:.leading){
            banner
            list
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
            Section(header: Text("Informations")
                .font(.title3.bold())
                .foregroundStyle(.gray)
                .padding(.vertical, 5)) {
                    ForEach(charactersDictionary, id: \.id) { row in
                        if row.hasNav {
                            NavigationLink(destination: LocationDetailView(locationId: locationId ?? 0)) {
                                InfoRowView(title: row.title, value: row.value)
                            }
                        } else {
                            InfoRowView(title: row.title, value: row.value)
                        }
                    }
                }
            Section(header:Text("Episodes")
                .font(.title3.bold())
                .foregroundStyle(.gray)
                .padding(.vertical, 5)){
                    ForEach(detailViewModel.episodes, id:\.id) { episode in
                        EpisodeCard(
                            episode: episode.episode,
                            id:      episode.id,
                            name:    episode.episode,
                            airDate: episode.airDate
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

struct SectionItem {
    let header: String
    let rows: [RowItem]
}

struct RowItem {
    let id = UUID()
    let title: String
    let value: String?
    
    var hasNav: Bool {
        title == "Location"
    }
    
}



extension CharacterDataModel {
    func toSections() -> [RowItem] {
        return [
            RowItem(title: "Name", value: name),
            RowItem(title: "Status", value: status),
            RowItem(title: "Species", value: species),
            RowItem(title: "Type", value: type.isEmpty ? "Unknown" : type),
            RowItem(title: "Gender", value: gender),
            RowItem(title: "Location", value: location.name)
        ]
    }
}

/*
fileprivate struct InfoRowWithNav: View {
    var title: String
    var value: String?
    var hasNav: Bool
    var locationId: Int?
    
    @ViewBuilder
    var body: some View {
        if hasNav {
            NavigationLink(destination: LocationDetailView(locationId: locationId ?? 0)) {
                InfoRowView(title: title, value: value)
            }
        } else {
            InfoRowView(title: title, value: value)
        }
    }
}

*/


#Preview {
    CharacterDetailView(characterId: 2)
}
