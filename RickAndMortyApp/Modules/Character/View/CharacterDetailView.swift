//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 7/7/24.
//

import SwiftUI


struct CharacterDetailView: View {
    
    var characterId: Int
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(alignment:.leading){
            banner
            list
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.character?.name ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .onAppear(){
            viewModel.fetchCharactersAndEpisodes(from: characterId)
        }
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
                
                createCharacterImageView(imageUrl: viewModel.character?.image  ?? "")
                
                Text(viewModel.character?.status ?? "")
                    .font(.caption2)
                    .foregroundStyle(.gray2)
                    .padding(.top, 10)
                   
                
                Text(viewModel.character?.name ?? "")
                    .font(.title.bold())
                
                Text(viewModel.character?.species ?? "")
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
                    ForEach(viewModel.charactersDictionary, id: \.id) { row in
                        if row.hasNav, let id = viewModel.locationId {
                            NavigationLink(destination: LocationDetailView(locationId: id)) {
                                infoRow(row.title, row.value)
                            }
                        } else {
                            infoRow(row.title, row.value)
                        }
                    }
                }
            Section(header:Text("Episodes")
                .font(.title3.bold())
                .foregroundStyle(.gray)
                .padding(.vertical, 5)){
                    ForEach(viewModel.episodes, id:\.id) { episode in
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
    
    private func infoRow(_ title: String, _ value: String?) -> some View {
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
    private func createCharacterImageView(imageUrl: String) -> some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                placeholderImage()
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
                placeholderImage()
            @unknown default:
                placeholderImage()
            }
        }
    }

    private func placeholderImage() -> some View {
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





#Preview {
    CharacterDetailView(characterId: 2)
}
