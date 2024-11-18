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
    @State private var filters = CharacterFilters()
    
    var body: some View {
        HeaderContainer(config: HeaderContainerConfiguration(title: "Character", isFilterPresented: $isPresented)) {
            CharacterListView(characters: characterViewModel.characterModel)
            .padding(.top,9)
            .background(.white)
            .padding(.bottom, 65)
    
        }
        .fullScreenCover(isPresented: $isPresented){
            FilterCharacter(
                filters: $filters,
                manager: characterViewModel
            )
        }
    }
}

#Preview {
    CharacterView()
}
