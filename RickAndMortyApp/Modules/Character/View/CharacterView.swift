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
    @State private var status:    String = ""
    @State private var species:   String = ""
    @State private var name:      String = ""
    
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: gridLayout, spacing: 20){
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
            .navigationTitle("Character")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isPresented = true }) {
                        Text("Filter")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Indigo"))
                    }
                }
            }
            .background(Color("Gray7"))
        }
        .onAppear{
            
            characterViewModel.getCharacters(from: "page=19")
        }
        .fullScreenCover(isPresented: $isPresented, onDismiss: { isPresented = false}){
            FilterCharacter(status: $status,
                            gender: $gender, 
                            species: $species,
                            name: $name,
                            isPresented: $isPresented,
                            manager: characterViewModel
            )
        }
    }
}

#Preview {
    CharacterView()
}
