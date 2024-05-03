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
        ZStack {
            Color.green
            Text("Character view")
        }.onAppear{
           
            print(characterViewModel.getCharacters())
        }
    }
}

#Preview {
    CharacterView()
}
