//
//  CharacterListView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 18/11/24.
//

import SwiftUI

struct CharacterListView: View {
    
    var characters: [CharacterDO]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: Constansts.gridLayout){
                ForEach(characters, id:\.id){ character in
                    NavigationLink(destination: CharacterDetailView(id: character.id)) {
                        CharacterCard(
                            character.status,
                            character.name,
                            character.image
                        )
                    }
                }
            }
        }
    }
    
    
    private func CharacterCard(_ status: String,_ name: String,_ img:String)-> some View {
        VStack(alignment: .leading) {
            
            characterImage(url: img, name: name)
            
            Text(status)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.leading)
                .padding(.top, 5)
            
            Text(name)
                .font(.headline)
                .foregroundStyle(.black)
                .fontWeight(.semibold)
                .padding(.horizontal)
            Spacer()
        }
        .frame(width: 163, height: 219)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("Gray3"), lineWidth: 1)
        )
    }
    
    
    private func characterImage(url: String, name: String) -> some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                placeholderImage
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                
            case .failure:
                placeholderImage
            @unknown default:
                placeholderImage
            }
        }
        .frame(height: 140)
        .clipped()
        .accessibilityLabel("Image of \(name)")
    }
    
    private var placeholderImage: some View {
        Image("image")
            .resizable()
            .scaledToFill()
    }
    
}

