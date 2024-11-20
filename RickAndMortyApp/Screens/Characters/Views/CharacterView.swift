//
//  CharacterView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/5/24.
//

import SwiftUI

struct CharacterFilter {
    var status = String()
    var gender = String()
    var species = String()
    var name = String()
}

struct CharacterView: View {
    
    @StateObject private var viewModel = CharacterOO()
    
    @State private var isPresented: Bool = false
    @State private var filters = CharacterFilter()
    
    var body: some View {
        HeaderContainer(config: HeaderContainerConfiguration(title: "Character", isFilterPresented: $isPresented)) {
            ScrollView {
                CharacterListView(characters: viewModel.characters)
                    .padding(.top,9)
                    .background(.white)
                    .padding(.bottom, 65)
            }
    
        }
        .fullScreenCover(isPresented: $isPresented){
            FilterCharacterView(
                filters: $filters,
                manager: viewModel
            )
        }
    }
}

#Preview {
    CharacterView()
}
