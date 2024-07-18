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
            AsyncImage(url:URL(string: img)){ phase in
                phase
                    .resizable()
                    .padding(.bottom, 5)
                    .scaledToFill()
                    .frame(height: 140)
                    .clipped()
            }placeholder: {
                Image("image")
                    .resizable()
                    .padding(.bottom, 5)
                    .scaledToFill()
                    .frame(height: 120)
                    .clipped()
            }
                Text(status)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                .padding([.leading])
                
                Text(name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .padding([.horizontal, .bottom])
            
            Spacer()

        }
        .frame(width: 178, height: 219)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("Gray3"), lineWidth: 1)
        )
        
    }
}

#Preview {
    CharacterCard(status: "Status", name: "Pepperoni pizza", img: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
}
