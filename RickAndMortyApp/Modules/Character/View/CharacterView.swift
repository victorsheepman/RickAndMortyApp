//
//  CharacterView.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 2/5/24.
//

import SwiftUI

struct CharacterView: View {
    @StateObject var characterViewModel = CharacterViewModel()
    @State var isPresented:Bool = false
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: layout){
                    ForEach(characterViewModel.characterModel, id:\.id){ character in
                        
                        CharacterCard(status: character.status, name: character.name, img: character.image)
                        
                    }
                }.padding(.bottom, 65)
                    .padding(.top,15)
            }
            .navigationTitle("Character")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresented = true
                    })
                    {
                        Text("Filter")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("Indigo"))
                    }
                }
            }
        }
        .onAppear{
            
            characterViewModel.getCharacters()
        }
        .fullScreenCover(isPresented: $isPresented,
                         onDismiss: { isPresented = false},
                         content:
                            {
            FilterCharacter()
            
        }
        )
    }
}

#Preview {
    CharacterView()
}
