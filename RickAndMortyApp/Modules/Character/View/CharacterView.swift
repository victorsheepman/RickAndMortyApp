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
    var body: some View {
        NavigationView {
            List(characterViewModel.characterModel, id: \.id) { character in
                Text(character.name)
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
                         content: {
                            ///componente filter
                        }
        )
    }
}

#Preview {
    CharacterView()
}
