//
//  CharacterCard.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 4/7/24.
//

import SwiftUI

struct CharacterCard: View {
    var status: String
    var name:   String
    var img:    String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            characterImage(url: img)
            
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
    
    @ViewBuilder
    private func characterImage(url: String) -> some View {
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

#Preview {
    CharacterCard(status: "Status", name: "Planet Blue", img: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
}
