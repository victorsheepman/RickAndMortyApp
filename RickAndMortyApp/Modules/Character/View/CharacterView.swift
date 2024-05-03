//
//  CharacterView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/5/24.
//

import SwiftUI

struct CharacterView: View {
    @StateObject var characterViewModel = CharacterViewModel()
    var body: some View {
        NavigationView {
            List(characterViewModel.characterModel, id: \.id) { character in
                        Text(character.name)
                   }
                   .navigationTitle("Characters")
               }.onAppear{
           
            characterViewModel.getCharacters()
        }
    }
}

#Preview {
    CharacterView()
}
