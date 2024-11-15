//
//  CharacterView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/5/24.
//

import SwiftUI

struct CharacterView: View {
    
    @StateObject private var characterViewModel = CharacterViewModel()
    
    @State private var isPresented: Bool = false
    @State private var gender:    String = ""
    @State private var species:   String = ""
    @State private var name:      String = ""
    @State private var status:    String = ""
    
  
    var body: some View {
        HeaderContainer(config: HeaderContainerConfiguration(title: "Character", isFilterPresented: $isPresented)) {
            LazyVGrid(columns: Constansts.gridLayout, spacing: 20){
                ForEach(characterViewModel.characterModel, id:\.id){ character in
                    NavigationLink(destination: CharacterDetailView( characterId: character.id)) {
                        CharacterCard(status: character.status, name: character.name, img: character.image)
                    }
                }
            }
            .padding(.top,9)
            .background(.white)
            .padding(.bottom, 65)
    
        }
        .fullScreenCover(isPresented: $isPresented, onDismiss: { isPresented = false}){
            FilterCharacter(
                status: $status,
                gender: $gender,
                species: $species,
                name: $name,
                manager: characterViewModel
            )
        }
    }
}

#Preview {
    CharacterView()
}
